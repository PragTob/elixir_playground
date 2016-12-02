alias Benchee.Formatters.{Console, HTML}

n = 10_000
range = 1..n
list  = Enum.to_list range
fun   = fn -> 0 end

Benchee.run %{
  "Enum.each" => fn -> Enum.each(list, fn(_) -> fun.() end) end,
  "List comprehension" => fn -> for _ <- list, do: fun.() end,
  "Recursion" => fn -> RepeatN.repeat_n(fun, n) end
}, formatters: [&Console.output/1, &HTML.output/1],
html: [file: "bench/output/repeat_n.html"]
