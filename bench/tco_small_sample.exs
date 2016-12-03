alias Benchee.Formatters.{Console, HTML}

map_fun = fn(i) -> i + 1 end
inputs = %{
  "Small (10 Thousand)"   => Enum.to_list(1..10_000),
  "Middle (100 Thousand)" => Enum.to_list(1..100_000),
  "Big (1 Million)"       => Enum.to_list(1..1_000_000),
  "Bigger (5 Million)"    => Enum.to_list(1..5_000_000)
}

Benchee.run %{
  "tail-recursive" =>
    fn(list) -> MyMap.map_tco(list, map_fun) end,
  "stdlib map" =>
    fn(list) -> Enum.map(list, map_fun) end,
  "body-recursive" =>
    fn(list) -> MyMap.map_body(list, map_fun) end
}, time: 20, warmup: 10, inputs: inputs,
   formatters: [&Console.output/1, &HTML.output/1],
   html: [file: "bench/output/tco_small_sample.html"]

# tobi@speedy ~/github/elixir_playground $ mix run bench/tco_blog_post_focussed_inputs.exs
# Erlang/OTP 19 [erts-8.1] [source] [64-bit] [smp:8:8] [async-threads:10] [hipe] [kernel-poll:false]
# Elixir 1.3.4
# Benchmark suite executing with the following configuration:
# warmup: 5.0s
# time: 15.0s
# parallel: 1
# inputs: Big (10 Million), Middle (100 Thousand), Small (1 Thousand)
# Estimated total run time: 240.0s
#
#
# Benchmarking with input Big (10 Million):
# Benchmarking map simple body-recursive...
# Benchmarking map tail-recursive...
# Benchmarking map tail-recursive different argument order...
# Benchmarking stdlib map...
#
# Benchmarking with input Middle (100 Thousand):
# Benchmarking map simple body-recursive...
# Benchmarking map tail-recursive...
# Benchmarking map tail-recursive different argument order...
# Benchmarking stdlib map...
#
# Benchmarking with input Small (1 Thousand):
# Benchmarking map simple body-recursive...
# Benchmarking map tail-recursive...
# Benchmarking map tail-recursive different argument order...
# Benchmarking stdlib map...
#
# ##### With input Big (10 Million) #####
# Name                                                  ips        average  deviation         median
# map tail-recursive different argument order          5.09      196.48 ms     ±9.70%      191.18 ms
# map tail-recursive                                   3.86      258.84 ms    ±22.05%      246.03 ms
# stdlib map                                           2.87      348.36 ms     ±9.02%      345.21 ms
# map simple body-recursive                            2.85      350.80 ms     ±9.03%      349.33 ms
#
# Comparison:
# map tail-recursive different argument order          5.09
# map tail-recursive                                   3.86 - 1.32x slower
# stdlib map                                           2.87 - 1.77x slower
# map simple body-recursive                            2.85 - 1.79x slower
#
# ##### With input Middle (100 Thousand) #####
# Name                                                  ips        average  deviation         median
# stdlib map                                         584.79        1.71 ms    ±16.20%        1.67 ms
# map simple body-recursive                          581.89        1.72 ms    ±15.38%        1.68 ms
# map tail-recursive different argument order        531.09        1.88 ms    ±17.41%        1.95 ms
# map tail-recursive                                 471.64        2.12 ms    ±18.93%        2.13 ms
#
# Comparison:
# stdlib map                                         584.79
# map simple body-recursive                          581.89 - 1.00x slower
# map tail-recursive different argument order        531.09 - 1.10x slower
# map tail-recursive                                 471.64 - 1.24x slower
#
# ##### With input Small (1 Thousand) #####
# Name                                                  ips        average  deviation         median
# stdlib map                                        66.10 K       15.13 μs    ±58.17%       15.00 μs
# map tail-recursive different argument order       62.46 K       16.01 μs    ±31.43%       15.00 μs
# map simple body-recursive                         62.35 K       16.04 μs    ±60.37%       15.00 μs
# map tail-recursive                                55.68 K       17.96 μs    ±30.32%       17.00 μs
#
# Comparison:
# stdlib map                                        66.10 K
# map tail-recursive different argument order       62.46 K - 1.06x slower
# map simple body-recursive                         62.35 K - 1.06x slower
# map tail-recursive                                55.68 K - 1.19x slower
