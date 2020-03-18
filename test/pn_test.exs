defmodule PNTest do
  use ExUnit.Case, async: true

  import PN

  test "1" do
    assert evaluate("1") == 1
  end

  test "1 30 -" do
    assert evaluate("1 30 -") == -29
  end

  test "2 5 +" do
    assert evaluate("2 5 +") == 7
  end

  test "3 6 * 2 /" do
    assert evaluate("3 6 * 2 /") == 9
  end

  test "3 4 2 * -" do
    assert evaluate("3 4 2 * -") == -5
  end

  test "10 9 8 7 - + +" do
    assert evaluate("10 9 8 7 - + +") == 20
  end
end
