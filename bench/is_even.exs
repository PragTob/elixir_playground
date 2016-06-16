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
# is_even?                              10.26     97449.21μs     (±0.50%)     97263.00μs
# is_even_tco?                           9.39    106484.48μs     (±0.09%)    106459.50μs
#
# Comparison:
# is_even?                              10.26
# is_even_tco?                           9.39 - 1.09x slower
