defmodule DeepMerge do
  @doc """
  iex> DeepMerge.deep_merge(%{a: 1, b: 2}, %{b: 3, c: 4})
  %{a: 1, b: 3, c: 4}
  iex> DeepMerge.deep_merge(%{a: 1, b: %{x: 10, y: 9}}, %{b: %{y: 20, z: 30}, c: 4})
  %{a: 1, b: %{x: 10, y: 20, z: 30}, c: 4}
  iex> DeepMerge.deep_merge(%{a: 1, b: %{x: 10, y: 9}}, %{b: 5, c: 4})
  %{a: 1, b: 5, c: 4}
  iex> DeepMerge.deep_merge(%{a: %{b: %{c: %{d: "foo", e: 2}}}}, %{a: %{b: %{c: %{d: "bar"}}}})
  %{a: %{b: %{c: %{d: "bar", e: 2}}}}
  """
  def deep_merge(base_map, override) do
    Map.merge base_map, override, &deep_merge_resolver/3
  end

  @doc """
  iex> DeepMerge.deep_merge(%{a: 1, b: 2}, %{b: 3, c: 4}, fn(_, _, _) -> :conflict end)
  %{a: 1, b: :conflict, c: 4}
  iex> simple_resolver = fn(_key, _base, override) -> override end
  iex> DeepMerge.deep_merge(%{a: 1, b: %{x: 10, y: 9}}, %{b: 5, c: 4}, simple_resolver)
  %{a: 1, b: 5, c: 4}
  """
  def deep_merge(base_map, override_map, fun) do
    # build a function to resolve the merges here and then use an actual
    # do_deep_merge function to do the merges and refer to that one
    # when really merging within the built functions

    Map.merge base_map, override_map, build_deep_merge_resolver(fun)
  end

  defp build_deep_merge_resolver(fun) do
    fn
      _key, base_map, override_map when is_map(base_map) and is_map(override_map) ->
        deep_merge(base_map, override_map, fun)
      key, base, override ->
        fun.(key, base, override)
    end
  end

  defp deep_merge_resolver(_key, base_map, override_map) when is_map(base_map) and is_map(override_map) do
    deep_merge(base_map, override_map)
  end

  defp deep_merge_resolver(_key, _base, override) do
    override
  end
end