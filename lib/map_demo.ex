defmodule MapDemo do
  @doc """
  iex> MapDemo.map [1, 2, 3, 4], fn i -> i + 1 end
  [2, 3, 4, 5]
  """
  def map(list, function) do
    Enum.reverse(do_map([], list, function))
  end

  defp do_map(acc, [], _function) do
    acc
  end

  defp do_map(acc, [head | tail], function) do
    do_map([function.(head) | acc], tail, function)
  end
end
