list = Enum.to_list(1..10_000)
map_fun = fn(i) -> i + 1 end

Benchee.run %{time: 10, warmup: 10}, [
  {"stdlib map",
  fn -> Enum.map(list, map_fun) end},
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
  {"map simple without TCO",
   fn -> MyMap.map_body(list, map_fun) end},
  {"map TCO no reverse",
   fn -> MyMap.map_tco_no_reverse(list, map_fun) end}
]


# tobi@happy ~/github/elixir_playground $ mix run bench/my_map_bench.exs
# Benchmarking stdlib map...
# Benchmarking map with TCO reverse...
# Benchmarking exactly_like_my_map...
# Benchmarking map with TCO reverse new acc...
# Benchmarking map with TCO reverse new arg order...
# Benchmarking my_map...
# Benchmarking map with TCO reverse at acc...
# Benchmarking map simple without TCO...
# Benchmarking map TCO no reverse...
#
# Name                                    ips        average    deviation         median
# map simple without TCO              6321.93       158.18μs     (±8.01%)       155.00μs
# stdlib map                          6220.67       160.75μs     (±9.85%)       158.00μs
# map TCO no reverse                  6127.18       163.21μs     (±8.55%)       159.00μs
# exactly_like_my_map                 6041.08       165.53μs    (±11.67%)       160.00μs
# my_map                              5954.40       167.94μs    (±13.25%)       160.00μs
# map with TCO reverse new arg o      5922.88       168.84μs    (±13.86%)       160.00μs
# map with TCO reverse at acc         5526.78       180.94μs     (±8.77%)       176.00μs
# map with TCO reverse new acc        5489.43       182.17μs     (±9.95%)       176.00μs
# map with TCO reverse                5139.48       194.57μs    (±12.38%)       199.00μs
#
# Comparison:
# map simple without TCO              6321.93
# stdlib map                          6220.67 - 1.02x slower
# map TCO no reverse                  6127.18 - 1.03x slower
# exactly_like_my_map                 6041.08 - 1.05x slower
# my_map                              5954.40 - 1.06x slower
# map with TCO reverse new arg o      5922.88 - 1.07x slower
# map with TCO reverse at acc         5526.78 - 1.14x slower
# map with TCO reverse new acc        5489.43 - 1.15x slower
# map with TCO reverse                5139.48 - 1.23x slower
