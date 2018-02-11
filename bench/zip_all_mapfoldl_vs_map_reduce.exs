one_hundred = Enum.to_list(1..100)
inputs = %{
  "100, 100, 100" => [one_hundred, one_hundred, one_hundred],
  "1000, 2000, 1500" => [Enum.to_list(1..1000), Enum.to_list(1..2000), Enum.to_list(1..1500)],
  "400 * 100" => Enum.map(1..400, fn _ -> one_hundred end)
}

Benchee.run %{
  "zip with mapfoldl" => fn(lists) -> Zip.all(lists) end,
  "zip with map_reduce" => fn(lists) -> Zip.all_map_reduce(lists) end
}, inputs: inputs