list = Enum.to_list(1..10_000)

Benchee.run [
  {"map with TCO reverse", fn -> MyMap.map(list, fn(i) -> i + 1 end) end},
  {"map with TCO and ++", fn -> MyMap.map2(list, fn(i) -> i + 1 end) end},
  {"map simple without TCO", fn -> MyMap.map3(list, fn(i) -> i + 1 end) end}
]
