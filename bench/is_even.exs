number = 10_000_000

Benchee.run [
  {"is_even?", fn -> Number.is_even?(number) end },
  {"is_even_tco?", fn -> Number.is_even_tco?(number) end }
]

# tobi@happy ~/github/elixir_playground $ mix run bench/is_even.exs
# Benchmarking is_even?...
# Benchmarking is_even_tco?...
#
# Name                                    ips        average    deviation         median
# is_even_tco?                          21.09     47417.30μs     (±6.91%)     46489.00μs
# is_even?                              10.22     97815.08μs     (±0.45%)     97754.00μs
#
# Comparison:
# is_even_tco?                          21.09
# is_even?                              10.22 - 2.06x slower
