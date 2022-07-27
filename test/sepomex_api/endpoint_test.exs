defmodule SepomexAPI.EndpointTest do
  use ExUnit.Case, async: true
  use Plug.Test

  alias SepomexAPI.Endpoint

  @opts SepomexAPI.Endpoint.init([])

  @zip_code_results ~s|[{"city":{"code":"03","name":"Ciudad de México"},"municipality":{"code":"014","name":"Benito Juárez"},"office":"03001","postal_code":"03100","settlement":{"code":"0496","name":"Del Valle Centro"},"settlement_type":{"code":"09","name":"Colonia"},"state":{"code":"09","name":"Ciudad de México"},"zone":"Urbano"},{"city":{"code":"03","name":"Ciudad de México"},"municipality":{"code":"014","name":"Benito Juárez"},"office":"03001","postal_code":"03100","settlement":{"code":"2624","name":"Insurgentes San Borja"},"settlement_type":{"code":"09","name":"Colonia"},"state":{"code":"09","name":"Ciudad de México"},"zone":"Urbano"}]|

  test "hello world" do
    conn = conn(:get, "/")
    conn = Endpoint.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "{\"message\":\"Hello World!\"}"
  end

  describe "zip_codes" do
    test "when zip code is valid" do
      conn = conn(:get, "/zip_codes?zip_code=03100")
      conn = Endpoint.call(conn, @opts)

      assert conn.state == :sent
      assert conn.status == 200
      assert conn.resp_body == @zip_code_results
    end

    test "when zip code does not exists" do
      conn = conn(:get, "/zip_codes?zip_code=00000")
      conn = Endpoint.call(conn, @opts)

      assert conn.state == :sent
      assert conn.status == 200
      assert conn.resp_body == "[]"
    end
  end

  describe "zip_code" do
    test "when zip code is valid" do
      conn = conn(:get, "/03100")
      conn = Endpoint.call(conn, @opts)

      assert conn.state == :sent
      assert conn.status == 200
      assert conn.resp_body == @zip_code_results
    end

    test "when zip code does not exists" do
      conn = conn(:get, "/00000")
      conn = Endpoint.call(conn, @opts)

      assert conn.state == :sent
      assert conn.status == 200
      assert conn.resp_body == "[]"
    end
  end
end
