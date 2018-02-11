defmodule Zip do
  @doc """
  ## Examples

      iex> Zip.all([[1, 2], [3, 4], [5, 6]])
      [[1, 3, 5], [2, 4, 6]]

      iex> Zip.all([[1, 2, 3], [3, 4], [5, 6]])
      [[1, 3, 5], [2, 4, 6], [3, nil, nil]]

      iex> Zip.all([[1, 2, 3], [3, 4], [5, 6, 7, 8]])
      [[1, 3, 5], [2, 4, 6], [3, nil, 7], [nil, nil, 8]]

      iex> Zip.all([[], [], []])
      []

      iex> Zip.all([[], [], [4], []])
      [[nil, nil, 4, nil]]
  """
  def all(list_of_lists) do
    do_zip(list_of_lists, [])
  end

  defp do_zip(list_of_lists, acc) do
    converter = fn list, acc -> do_zip_each(list, acc) end
    {remaining, heads} = :lists.mapfoldl(converter, [], list_of_lists)
    do_zip_recur(remaining, heads, acc)
  end

  defp do_zip_each([], acc), do: {[], [nil | acc]}
  defp do_zip_each([head | tail], acc), do: {tail, [head | acc]}

  defp do_zip_recur(remaining, heads, acc) do
    if Enum.all?(heads, &is_nil/1) do
      Enum.reverse(acc)
    else
      do_zip(remaining, [Enum.reverse(heads) | acc])
    end
  end

  @doc """
  ## Examples

      iex> Zip.all_map_reduce([[1, 2], [3, 4], [5, 6]])
      [[1, 3, 5], [2, 4, 6]]

      iex> Zip.all_map_reduce([[1, 2, 3], [3, 4], [5, 6]])
      [[1, 3, 5], [2, 4, 6], [3, nil, nil]]

      iex> Zip.all_map_reduce([[1, 2, 3], [3, 4], [5, 6, 7, 8]])
      [[1, 3, 5], [2, 4, 6], [3, nil, 7], [nil, nil, 8]]

      iex> Zip.all_map_reduce([[], [], []])
      []

      iex> Zip.all_map_reduce([[], [], [4], []])
      [[nil, nil, 4, nil]]
  """
  def all_map_reduce(list_of_lists) do
    do_zip_map_reduce(list_of_lists, [])
  end

  defp do_zip_map_reduce(list_of_lists, acc) do
    converter = fn list, acc -> do_zip_each(list, acc) end
    {remaining, heads} = Enum.map_reduce(list_of_lists, [], converter)
    do_zip_recur_map_reduce(remaining, heads, acc)
  end

  defp do_zip_recur_map_reduce(remaining, heads, acc) do
    if Enum.all?(heads, &is_nil/1) do
      Enum.reverse(acc)
    else
      do_zip_map_reduce(remaining, [Enum.reverse(heads) | acc])
    end
  end
end