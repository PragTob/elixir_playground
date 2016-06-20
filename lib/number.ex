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

  @doc """
  iex> Number.is_even_tco_new_acc? 1
  false

  iex> Number.is_even_tco_new_acc? 2
  true

  iex> Number.is_even_tco_new_acc? 7856
  true

  iex> Number.is_even_tco_new_acc? 8769
  false
  """
  def is_even_tco_new_acc?(n, acc \\ true)
  def is_even_tco_new_acc?(0, acc), do: acc
  def is_even_tco_new_acc?(n, acc) do
    new_n   = n - 1
    new_acc = !acc
    is_even_tco_new_acc?(new_n, new_acc)
  end
end
