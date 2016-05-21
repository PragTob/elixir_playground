defmodule MyMap do
  def map(list, function) do
    Enum.reverse _map([], list, function)
  end

  defp _map(acc, [head | tail], function) do
    _map([function.(head) | acc], tail, function)
  end


  defp _map(acc, [], _function) do
    acc
  end
end
