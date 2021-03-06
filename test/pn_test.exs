defmodule PNTest do
  use ExUnit.Case, async: true

  # Same interface would best be enforced via behavior, but seems overkill as of now
  @modules [PN, PN2]

  @test_cases %{
    "1" => 1,
    "1 30 -" => -29,
    "2 5 +" => 7,
    "3 6 * 2 /" => 9,
    "3 4 2 * -" => -5,
    "10 9 8 7 - + +" => 20,
    "10 9 8 7 - + + 2 /" => 10,
    "10 9 8 7 - + + 1 1 + /" => 10,
    "15 7 1 1 + - / 3 * 2 1 1 + + -" => 5
  }

  for module <- @modules do
    @module module

    describe "#{@module}" do
      for {notation, result} <- @test_cases do
        @notation notation
        @result result

        test "'#{@notation}' evaluates to #{result}" do
          assert @module.evaluate(@notation) == @result
        end
      end
    end
  end
end
