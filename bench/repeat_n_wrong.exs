alias Benchee.Formatters.{Console, HTML}

n = 10_000
fun = fn -> 0 end

Benchee.run(
  %{
    "Enum.each" => fn ->
      Enum.each(Enum.to_list(1..n), fn _ -> fun.() end)
    end,
    "List comprehension" => fn ->
      for _ <- Enum.to_list(1..n), do: fun.()
    end,
    "Recursion" => fn -> RepeatN.repeat_n(fun, n) end
  },
  formatters: [&Console.output/1, &HTML.output/1],
  html: [file: "bench/output/repeat_n.html"]
)
