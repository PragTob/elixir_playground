defmodule PN do
  @moduledoc """
  2 5 +
  equivalent to: 2 + 5 = 7
  output: 7

  1 30 -
  equivalent to: 1 - 30 = -29
  output: -29

  3 6 * 2 /
  equivalent to: (3 * 6) / 2 = 9
  output: 9

  3 4 2 * -
  equivalent to: 3 - (4 * 2) = -5
  output: -5

  10 9 8 7 - + +
  equivalent to: 10 + (9 + (8 - 7)) = 20
  output: 20

  1
  output: 1

  ## Constraints
  * String space delinited is input
  * no need to worry about broken inputs
  """

  require IEx

  @operands ["+", "-", "*", "/"]

  def evaluate(notation) do
    notation
    |> String.split(" ")
    |> Enum.map(&normalize/1)
    |> do_eval
  end

  defp normalize(element) when element in @operands do
    element
  end

  defp normalize(element) do
    String.to_integer(element)
  end

  defp do_eval([value]) do
    value
  end

  defp do_eval([_a, b, _c | _tail] = list) when b in @operands do
    list
  end

  defp do_eval([first, second, "-"]) do
    first - second
  end

  defp do_eval([first, second, "+"]) do
    first + second
  end

  defp do_eval([first, second, "*"]) do
    first * second
  end

  defp do_eval([first, second, "/"]) do
    first / second
  end

  defp do_eval([a, b, c | tail]) when c in @operands do
    do_eval([do_eval([a, b, c]) | tail])
  end

  defp do_eval([a, b, c | tail]) do
    do_eval([a | do_eval([b, c | tail])])
  end

  defp do_eval(value) do
    value
  end
end
