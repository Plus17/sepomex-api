defmodule SepomexAPI.EndpointTest do
	use ExUnit.Case, async: true
	use Plug.Test


	alias SepomexAPI.Endpoint

  @opts SepomexAPI.Endpoint.init([])

  test "hello world" do
    conn = conn(:get, "/")
    conn = Endpoint.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "{\"message\":\"Hello World!\"}"
  end
end
