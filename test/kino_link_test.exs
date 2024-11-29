defmodule KinoLinkTest do
  use ExUnit.Case
  doctest KinoLink

  test "greets the world" do
    assert KinoLink.hello() == :world
  end
end
