file = File.open!("tco.csv", [:write])
list = Enum.to_list(1..10_000)
map_fun = fn i -> i + 1 end

stats =
  %{time: 10, warmup: 10}
  |> Benchee.init()
  |> Benchee.benchmark(
    "map with TCO reverse",
    fn -> MyMap.map_tco(list, map_fun) end
  )
  |> Benchee.benchmark(
    "map simple without TCO",
    fn -> MyMap.map_body(list, map_fun) end
  )
  |> Benchee.benchmark(
    "map with TCO new arg order",
    fn -> MyMap.map_tco_arg_order(list, map_fun) end
  )
  |> Benchee.benchmark("stdlib map", fn -> Enum.map(list, map_fun) end)
  |> Benchee.benchmark(
    "map TCO no reverse",
    fn -> MyMap.map_tco_no_reverse(list, map_fun) end
  )
  |> Benchee.benchmark(
    "map tail-recursive with ++",
    fn -> MyMap.map_tco_concat(list, map_fun) end
  )
  |> Benchee.measure()
  |> Benchee.statistics()

stats
|> Benchee.Formatters.CSV.format()
|> Enum.each(fn row -> IO.write(file, row) end)

stats
|> Benchee.Formatters.Console.format()
|> IO.puts()
