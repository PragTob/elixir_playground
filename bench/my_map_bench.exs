list = Enum.to_list(1..10_000)
map_fun = fn(i) -> i + 1 end

Benchee.run %{time: 5, warmup: 2}, [
  {"map with TCO reverse",
   fn -> MyMap.map_tco(list, map_fun) end},
  {"exactly_like_my_map",
   fn -> MyMap.exactly_like_my_map(list, map_fun) end},
  {"map with TCO reverse new acc",
   fn -> MyMap.map_tco_new_acc(list, map_fun) end},
  {"map with TCO reverse new arg order",
    fn -> MyMap.map_tco_arg_order(list, map_fun) end},
  {"my_map",
   fn -> MyMap.my_map(list, map_fun) end},
  {"map with TCO reverse at acc",
   fn -> MyMap.map_tco_reverse_at_acc(list, map_fun) end},
  {"map with TCO and ++",
   fn -> MyMap.map_tco_concat(list, map_fun) end},
  {"map simple without TCO",
   fn -> MyMap.map_body(list, map_fun) end},
  {"map TCO no reverse",
   fn -> MyMap.map_tco_no_reverse(list, map_fun) end},
  {"stdlib map",
   fn -> Enum.map(list, map_fun) end}
]


# tobi@happy ~/github/elixir_playground $ mix run bench/my_map_bench.exs
# Compiled lib/my_map.ex
# Benchmarking map with TCO reverse...
# Benchmarking map with TCO reverse new acc...
# Benchmarking map with TCO and ++...
# Benchmarking map simple without TCO...
# Benchmarking map TCO no reverse...
# Benchmarking stdlib map...
#
# Name                                    ips        average    deviation         median
# map simple without TCO              6394.66       156.38μs     (±2.29%)       156.00μs
# stdlib map                          6329.18       158.00μs     (±4.76%)       156.00μs
# map TCO no reverse                  5765.90       173.43μs     (±5.07%)       171.00μs
# map with TCO reverse                4951.56       201.96μs     (±7.95%)       198.00μs
# map with TCO reverse new acc        4934.26       202.66μs     (±7.62%)       211.00μs
# map with TCO and ++                    5.76    173759.37μs     (±0.52%)    173450.00μs
#
# Comparison:
# map simple without TCO              6394.66
# stdlib map                          6329.18 - 1.01x slower
# map TCO no reverse                  5765.90 - 1.11x slower
# map with TCO reverse                4951.56 - 1.29x slower
# map with TCO reverse new acc        4934.26 - 1.30x slower
# map with TCO and ++                    5.76 - 1111.13x slower
