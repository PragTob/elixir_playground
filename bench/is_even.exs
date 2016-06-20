number = 10_000_000

Benchee.run %{warmup: 10, time: 10},  [
  {"is_even?", fn -> Number.is_even?(number) end },
  {"is_even_tco?", fn -> Number.is_even_tco?(number) end },
  {"is_even_tco_new_acc?", fn -> Number.is_even_tco_new_acc?(number) end },
]

# tobi@happy ~/github/elixir_playground $ mix run bench/is_even.exs 
# Benchmarking is_even?...
# Benchmarking is_even_tco?...
# Benchmarking is_even_tco_new_acc?...
#
# Name                                    ips        average    deviation         median
# is_even?                              10.05     99528.28μs     (±0.08%)     99510.00μs
# is_even_tco_new_acc?                   9.39    106468.71μs     (±0.05%)    106458.00μs
# is_even_tco?                           9.39    106473.06μs     (±0.06%)    106459.00μs
#
# Comparison:
# is_even?                              10.05
# is_even_tco_new_acc?                   9.39 - 1.07x slower
# is_even_tco?                           9.39 - 1.07x slower
