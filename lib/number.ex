defmodule Number do
  @doc """
  iex> Number.is_even? 1
  false

  iex> Number.is_even? 2
  true

  iex> Number.is_even? 7856
  true

  iex> Number.is_even? 8769
  false
  """
  def is_even?(0), do: true
  def is_even?(n) do
    !is_even?(n - 1)
  end

  @doc """
  iex> Number.is_even_tco? 1
  false

  iex> Number.is_even_tco? 2
  true

  iex> Number.is_even_tco? 7856
  true

  iex> Number.is_even_tco? 8769
  false
  """
  def is_even_tco?(n, acc \\ true)
  def is_even_tco?(0, acc), do: acc
  def is_even_tco?(n, acc) do
    is_even_tco?(n - 1, !acc)
  end
end
