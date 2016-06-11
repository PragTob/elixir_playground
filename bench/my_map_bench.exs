list = Enum.to_list(1..10_000)

Benchee.run [
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
