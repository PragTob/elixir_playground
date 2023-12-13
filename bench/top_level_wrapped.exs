defmodule Compiled do
  def comprehension(list) do
    for x <- list, rem(x, 2) == 1, do: x + 1
  end
end

defmodule MyBenchmark do
  def run do
    list = Enum.to_list(1..10_000)

    Benchee.run(%{
      "module (optimized)" => fn -> Compiled.comprehension(list) end,
      "top_level (non-optimized)" => fn -> for x <- list, rem(x, 2) == 1, do: x + 1 end
    })
  end
end

MyBenchmark.run()
