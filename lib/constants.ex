defmodule Constants do
  @my_constant "super constant"
  def my_constant do
    @my_constant
  end

  @my_constant "ch-ch-changes!"
  def my_constant_again do
    @my_constant
  end

  def my_other_constant do
    "This is cool as well"
  end
end
