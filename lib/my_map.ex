defmodule MyMap do

  @doc """
  iex> MyMap.map [1, 2, 3, 4], fn(i) -> i + 1 end
  [2, 3, 4, 5]
  """
  def map(list, function) do
    Enum.reverse _map([], list, function)
  end

  defp _map(acc, [head | tail], function) do
    _map([function.(head) | acc], tail, function)
  end

  defp _map(acc, [], _function) do
    acc
  end

  @doc """
  iex> MyMap.map2 [1, 2, 3, 4], fn(i) -> i + 1 end
  [2, 3, 4, 5]
  """
  def map2(acc \\ [], list, function)

  def map2(acc, [head | tail], function) do
    map2(acc ++ [function.(head)], tail, function)
  end

  def map2(acc, [], _function) do
    acc
  end

  @doc """
  iex> MyMap.map3 [1, 2, 3, 4], fn(i) -> i + 1 end
  [2, 3, 4, 5]
  """
  def map3([], _func), do: []

  def map3([head | tail], func) do
    [func.(head) | map(tail, func)]
  end
end
