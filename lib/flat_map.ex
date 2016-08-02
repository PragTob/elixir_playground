defmodule FlatMap do
  # v1
  # iex> FlatMap.flat_map([:a, :b, :c], fn(x) -> [x, x] end)
  # [:a, :a, :b, :b, :c, :c]
  def flat_map(enumerable, fun) when is_function(fun, 1) do
    Enum.reduce(enumerable, [], fn(entry, acc) ->
      case fun.(entry) do
        list when is_list(list) -> :lists.reverse(list, acc)
        other -> Enum.reduce(other, acc, &[&1 | &2])
      end
    end) |> :lists.reverse
  end

  # v2
  # iex> FlatMap.flat_map_list([:a, :b, :c], fn(x) -> [x, x] end)
  # [:a, :a, :b, :b, :c, :c]
  def flat_map_list([h | t], fun) do
    case fun.(h) do
      list when is_list(list) -> list ++ flat_map_list(t, fun)
      other -> Enum.to_list(other) ++ flat_map_list(t, fun)
    end
  end

  def flat_map_list([], fun) when is_function(fun, 1) do
    []
  end
end
