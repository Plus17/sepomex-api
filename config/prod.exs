use Mix.Config

config :sepomex_api, http_port: 80

config :sepomets, file: System.get_env("SEPOMEX_FILE_PATH")
