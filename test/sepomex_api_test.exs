defmodule SepomexAPITest do
  use ExUnit.Case
  doctest SepomexAPI

  test "greets the world" do
    assert SepomexAPI.hello() == :world
  end
end
