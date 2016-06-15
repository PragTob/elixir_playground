list = Enum.to_list(1..10_000)
file = File.open!("map.csv", [:write])
suite = Benchee.init
jobs =
 [
  {"map with TCO reverse",
   fn -> MyMap.map_tco(list, fn(i) -> i + 1 end) end},
  {"map with TCO and ++",
   fn -> MyMap.map_tco_concat(list, fn(i) -> i + 1 end) end},
  {"map simple without TCO",
   fn -> MyMap.map_body(list, fn(i) -> i + 1 end) end},
  {"map TCO no reverse",
   fn -> MyMap.map_tco_no_reverse(list, fn(i) -> i + 1 end) end},
  {"stdlib map",
   fn -> Enum.map(list, fn(i) -> i + 1 end) end}
]

%{suite | jobs: jobs}
|> Benchee.measure
|> Benchee.statistics
|> Benchee.Formatters.CSV.format
|> Enum.each(fn(row) -> IO.write(file, row) end)
