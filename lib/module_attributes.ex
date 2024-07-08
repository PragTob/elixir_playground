defmodule MyModuleAttributes do

  @value_fun &__MODULE__.value_fun/0
  def value_fun, do: 1234

  @doc """
      iex> use_it()
      1234
  """
  def use_it, do: @value_fun.()
end
