import Config

# config/runtime.exs is executed for all environments, including
# during releases. It is executed after compilation and before the
# system starts, so it is typically used to load production configuration
# and secrets from environment variables or elsewhere. Do not define
# any compile-time configuration in here, as it won't be applied.
# The block below contains prod specific runtime configuration.
if config_env() == :prod do
  config :sepomets, file: System.fetch_env!("SEPOMEX_FILE_PATH")

  config :sepomex_api, http_port: String.to_integer(System.fetch_env!("PORT"))
end
