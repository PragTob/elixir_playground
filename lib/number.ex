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
end
