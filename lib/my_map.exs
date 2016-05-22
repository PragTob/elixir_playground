defmodule MyMap do
  def map([], _func), do: []

  def map([head | tail], func) do
    [func.(head) | map(tail, func)]
  end
end

MyMap.map [1, 2, 3, 4], fn(i) -> i * i end
