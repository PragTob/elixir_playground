list = Enum.to_list(1..10_000)
map_fun = fn(i) -> i + 1 end

Benchee.run %{
  "map tail-recursive with ++" =>
    fn -> MyMap.map_tco_concat(list, map_fun) end,
  "map with TCO reverse" =>
    fn -> MyMap.map_tco(list, map_fun) end,
  "stdlib map" =>
    fn -> Enum.map(list, map_fun) end,
  "map simple without TCO" =>
    fn -> MyMap.map_body(list, map_fun) end,
  "map with TCO new arg order" =>
    fn -> MyMap.map_tco_arg_order(list, map_fun) end,
  "map TCO no reverse" =>
    fn -> MyMap.map_tco_no_reverse(list, map_fun) end
}, time: 10, warmup: 10

# tobi@speedy ~/github/elixir_playground $ mix run bench/tco_blog_post.exs 
# Erlang/OTP 19 [erts-8.1] [source] [64-bit] [smp:8:8] [async-threads:10] [hipe] [kernel-poll:false]
# Elixir 1.3.4
# Benchmark suite executing with the following configuration:
# warmup: 10.0s
# time: 10.0s
# parallel: 1
# inputs: none specified
# Estimated total run time: 120.0s
#
# Benchmarking map TCO no reverse...
# Benchmarking map simple without TCO...
# Benchmarking map tail-recursive with ++...
# Benchmarking map with TCO new arg order...
# Benchmarking map with TCO reverse...
# Benchmarking stdlib map...
#
# Name                                 ips        average  deviation         median
# map simple without TCO            5.99 K      167.01 μs     ±5.36%      165.00 μs
# stdlib map                        5.90 K      169.53 μs     ±1.73%      169.00 μs
# map TCO no reverse                5.67 K      176.40 μs     ±7.37%      174.00 μs
# map with TCO new arg order        5.46 K      183.17 μs    ±10.89%      187.00 μs
# map with TCO reverse              4.92 K      203.39 μs    ±10.28%      207.00 μs
# map tail-recursive with ++     0.00676 K   147908.93 μs     ±2.42%   146560.00 μs
#
# Comparison:
# map simple without TCO            5.99 K
# stdlib map                        5.90 K - 1.02x slower
# map TCO no reverse                5.67 K - 1.06x slower
# map with TCO new arg order        5.46 K - 1.10x slower
# map with TCO reverse              4.92 K - 1.22x slower
# map tail-recursive with ++     0.00676 K - 885.61x slower
