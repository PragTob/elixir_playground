defmodule PN2 do
  @moduledoc """
  Attempt at an easier implementation
  """

  @plus "+"
  @minus "-"
  @multiplication "*"
  @division "/"
  @operands [@plus, @minus, @multiplication, @division]

  @notation_separator " "

  def evaluate(notation) do
    notation
    |> String.split(@notation_separator)
    |> Enum.map(&normalize/1)
    |> do_eval
  end

  defp normalize(element) when element in @operands do
    element
  end

  defp normalize(element) do
    String.to_integer(element)
  end

  defp do_eval(list) do
    [result] =
      Enum.reduce(list, [], fn x, acc ->
        if x in @operands do
          [a, b | new_acc] = acc
          computed = evaluate_triplet(b, a, x)
          [computed | new_acc]
        else
          [x | acc]
        end
      end)

    result
  end

  defp evaluate_triplet(first, second, @minus) do
    first - second
  end

  defp evaluate_triplet(first, second, @plus) do
    first + second
  end

  defp evaluate_triplet(first, second, @multiplication) do
    first * second
  end

  defp evaluate_triplet(first, second, @division) do
    first / second
  end
end
