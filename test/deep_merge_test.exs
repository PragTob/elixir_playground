defmodule DeepMergeTest do
  use ExUnit.Case
  doctest DeepMerge

  test "deep_merge/3 with custom resolver" do
    res = DeepMerge.deep_merge %{a: %{b: [1]}}, %{a: %{b: [2]}}, fn(key, val1, val2) ->
      val1 ++ val2
    end

    assert res == %{a: %{b: [1, 2]}}
  end
end
