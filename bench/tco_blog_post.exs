list = Enum.to_list(1..10_000)
map_fun = fn(i) -> i + 1 end

Benchee.run %{time: 10, warmup: 10}, [
  {"map tail-recursive with ++",
   fn -> MyMap.map_tco_concat(list, map_fun) end},
  {"map with TCO reverse",
   fn -> MyMap.map_tco(list, map_fun) end},
  {"stdlib map",
   fn -> Enum.map(list, map_fun) end},
  {"map simple without TCO",
   fn -> MyMap.map_body(list, map_fun) end},
  {"map with TCO new arg order",
   fn -> MyMap.map_tco_arg_order(list, map_fun) end},
  {"map TCO no reverse",
   fn -> MyMap.map_tco_no_reverse(list, map_fun) end}
]

# tobi@happy ~/github/elixir_playground $ mix run bench/tco_blog_post_detailed.exs 
# Benchmarking map tail-recursive with ++...
# Benchmarking map TCO no reverse...
# Benchmarking stdlib map...
# Benchmarking map with TCO new arg order...
# Benchmarking map simple without TCO...
# Benchmarking map with TCO reverse...
#
# Name                                    ips        average    deviation         median
# map simple without TCO              6015.31       166.24μs     (±6.88%)       163.00μs
# stdlib map                          5815.97       171.94μs    (±11.29%)       163.00μs
# map with TCO new arg order          5761.46       173.57μs    (±10.24%)       167.00μs
# map TCO no reverse                  5566.08       179.66μs     (±6.39%)       177.00μs
# map with TCO reverse                5262.89       190.01μs     (±9.98%)       182.00μs
# map tail-recursive with ++             8.66    115494.33μs     (±2.86%)    113537.00μs
#
# Comparison:
# map simple without TCO              6015.31
# stdlib map                          5815.97 - 1.03x slower
# map with TCO new arg order          5761.46 - 1.04x slower
# map TCO no reverse                  5566.08 - 1.08x slower
# map with TCO reverse                5262.89 - 1.14x slower
# map tail-recursive with ++             8.66 - 694.73x slower
