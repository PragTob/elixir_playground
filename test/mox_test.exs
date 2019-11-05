defmodule MoxTest do
  use ExUnit.Case, async: true

  import Mox

  setup :verify_on_exit!

  test "it woofs" do
    assert BarkMock.bark() == "wooofff"
  end

  test "we can mock the woof" do
    # expect(BarkMock, :bark, fn -> "chirp chirp" end)
    assert BarkMock.bark() == "chirp chirp"
  end

  test "and woof again" do
    assert BarkMock.bark() == "wooofff"
  end
end
