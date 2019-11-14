defmodule Patterns do
  def greet(%{name: name, age: age}) do
    IO.puts("Hi there #{name}, what's up at #{age}?")
  end

  def greet(%{name: "Emily"}) do
    IO.puts("Thanks for running Øredev for so long!")
  end

  def greet(%{name: name}) do
    IO.puts("Hi there #{name}")
  end

  def greet(_) do
    IO.puts("Hi")
  end
end
