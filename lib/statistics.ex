defmodule Statistics do
  def compute_mode(samples) do
    samples
    |> Enum.reduce(%{}, fn sample, counts ->
      Map.update(counts, sample, 1, fn old_value -> old_value + 1 end)
    end)
    |> Enum.max_by(fn {_sample, occurences} -> occurences end)
  end

  @doc """
      iex> Statistics.compute_mode_advanced([5, 3, 4, 5, 1, 3, 1, 3])
      3

      iex> Statistics.compute_mode_advanced([])
      nil

      iex> Statistics.compute_mode_advanced([1, 2, 3, 4, 5])
      nil

      iex> [5, 3, 4, 5, 1, 3, 1] |> Statistics.compute_mode_advanced() |> Enum.sort
      [1, 3, 5]
  """
  def compute_mode_advanced(samples) do
    samples
    |> Enum.reduce(%{}, fn sample, counts ->
      Map.update(counts, sample, 1, fn old_value -> old_value + 1 end)
    end)
    |> max_multiple
    |> decide_mode
  end

  defp max_multiple(map) do
    max_multiple(Enum.to_list(map), [{nil, 0}])
  end

  defp max_multiple([{sample, occurence} | rest], ref = [{_sample, max_occurence} | _]) do
    new_ref =
      cond do
        occurence < max_occurence -> ref
        occurence == max_occurence -> [{sample, occurence} | ref]
        true -> [{sample, occurence}]
      end

    max_multiple(rest, new_ref)
  end

  defp max_multiple([], ref) do
    ref
  end

  defp decide_mode([{nil, _}]), do: nil
  defp decide_mode([{_, 1} | _rest]), do: nil
  defp decide_mode([{sample, _occurence}]), do: sample

  defp decide_mode(multi_modes) do
    Enum.map(multi_modes, fn {sample, _} -> sample end)
  end
end
