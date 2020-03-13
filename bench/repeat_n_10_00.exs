alias Benchee.Formatters.{Console, HTML}

n = 10_000
range = 1..n
list = Enum.to_list(range)
fun = fn -> 0 end

Benchee.run(
  %{
    "Enum.each (range)" => fn -> Enum.each(range, fn _ -> fun.() end) end,
    "List comprehension (range)" => fn -> for _ <- range, do: fun.() end,
    "Enum.each (list)" => fn -> Enum.each(list, fn _ -> fun.() end) end,
    "List comprehension (list)" => fn -> for _ <- list, do: fun.() end,
    "Recursion" => fn -> RepeatN.repeat_n(fun, n) end
  },
  formatters: [&Console.output/1, &HTML.output/1],
  html: [file: "bench/output/repeat_n_10_000.html"]
)
