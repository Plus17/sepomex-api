defmodule SepomexAPI.Endpoint do
  @moduledoc """
  Module to receive a reponse requests
  """

  use Plug.Router

  plug(Plug.Logger)

  plug(:match)

  plug(Plug.Parsers, parsers: [:json], json_decoder: Jason)

  plug(:dispatch)

  get "/" do
    json_body = Jason.encode!(%{"message" => "Hello World!"})

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, json_body)
  end

  match _ do
    send_resp(conn, 404, "Nothing here!")
  end
end
