defmodule PNTest do
  use ExUnit.Case, async: true

  import PN

  @test_cases %{
    "1" => 1,
    "1 30 -" => -29,
    "2 5 +" => 7,
    "3 6 * 2 /" => 9,
    "3 4 2 * -" => -5,
    "10 9 8 7 - + +" => 20
  }

  for {notation, result} <- @test_cases do
    @notation notation
    @result result

    test "'#{@notation}' evaluates to #{result}" do
      assert evaluate(@notation) == @result
    end
  end
end
