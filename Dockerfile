ARG MIX_ENV="prod"
ARG SEPOMEX_FILE_PATH="lib/sepomex_api-0.1.0/priv/sepomex.zip"

# build stage
FROM elixir:1.13-alpine AS build

# install build dependencies
RUN apk add curl python3 git

# sets work dir
WORKDIR /app

# install hex + rebar
RUN mix local.hex --force && \
  mix local.rebar --force

ARG MIX_ENV
ARG SEPOMEX_FILE_PATH
ENV MIX_ENV="${MIX_ENV}"
ENV SEPOMEX_FILE_PATH="${SEPOMEX_FILE_PATH}"

# install mix dependencies
COPY mix.exs mix.lock ./
RUN mix deps.get --only $MIX_ENV

# copy compile configuration files
RUN mkdir config
COPY config/config.exs config/$MIX_ENV.exs config/

# compile dependencies
RUN mix deps.compile

# copy assets
COPY priv priv

# compile project
COPY lib lib
RUN mix compile

# copy runtime configuration file
COPY config/runtime.exs config/

# assemble release
RUN mix release

# app stage
FROM alpine:3.15 AS app

ARG MIX_ENV
ARG SEPOMEX_FILE_PATH
ENV SEPOMEX_FILE_PATH="${SEPOMEX_FILE_PATH}"

# install runtime dependencies
RUN apk add --no-cache libstdc++ openssl ncurses-libs

ENV USER="elixir"

WORKDIR "/home/${USER}/app"

# Create  unprivileged user to run the release
RUN \
  addgroup \
  -g 1000 \
  -S "${USER}" \
  && adduser \
  -s /bin/sh \
  -u 1000 \
  -G "${USER}" \
  -h "/home/${USER}" \
  -D "${USER}" \
  && su "${USER}"

RUN chown -R "${USER}:${USER}" "/home/${USER}"

# run as user
USER "${USER}"

# copy release executables
COPY --from=build --chown="${USER}":"${USER}" /app/_build/"${MIX_ENV}"/rel/sepomex_api ./

CMD ["bin/sepomex_api", "start"]
