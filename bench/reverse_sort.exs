alias Benchee.Formatters.{Console, HTML}
list = 1..10_000 |> Enum.to_list |> Enum.shuffle

Benchee.run %{
  "sort(fun)" => fn -> Enum.sort(list, &(&1 > &2)) end,
  "sort |> reverse" => fn -> list |> Enum.sort |> Enum.reverse end,
  "sort_by(-value)" => fn -> Enum.sort_by(list, fn(val) -> -val end) end
}, formatters: [&Console.output/1, &HTML.output/1],
html: [file: "bench/output/reverse_sort.html"]
