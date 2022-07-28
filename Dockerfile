ARG MIX_ENV="prod"
ARG SEPOMEX_FILE_PATH="lib/sepomex_api-0.1.0/priv/sepomex.zip"

# build stage
FROM elixir:1.13-slim AS build

RUN apt update && apt upgrade -y && apt install -y build-essential curl python3 git
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash -

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
FROM debian:bullseye AS app

ENV REPLACE_OS_VARS=true

# For local dev, heroku will ignore this
EXPOSE $PORT

ARG MIX_ENV
ARG SEPOMEX_FILE_PATH
ENV SEPOMEX_FILE_PATH="${SEPOMEX_FILE_PATH}"

# install runtime dependencies
RUN apt update && apt upgrade -y && apt install -y libncurses-dev locales && locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

WORKDIR "/home/app"

# copy release executables
COPY --from=0 /app/_build/"${MIX_ENV}"/rel/sepomex_api ./

CMD PORT=$PORT exec bin/sepomex_api start
