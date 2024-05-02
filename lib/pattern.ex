defmodule Pattern do
  def map(%{}) do
    IO.puts("Empty map or is it?")
  end

  def list([]) do
    IO.puts("list is empty")
  end

  def list([element | tail]) do
    IO.inspect(element)
    list(tail)
  end

  def option(warning: true) do
    IO.puts "warning!"
  end

  def option(_anything) do
    IO.puts "No warning!"
  end
end
