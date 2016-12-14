defmodule Patterns do
  def greet(%{name: name, age: age}) do
    IO.puts "Hi there #{name}, what's up at #{age}?"
  end
  def greet(%{name: "Peter Schröder"}) do
    IO.puts "Hi Peter, thanks for onruby! <3"
  end
  def greet(%{name: name}) do
    IO.puts "Hi there #{name}"
  end
  def greet(_) do
    IO.puts "Hi"
  end
end