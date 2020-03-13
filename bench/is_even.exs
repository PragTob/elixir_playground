number = 10_000_000

Benchee.run(
  %{
    "is_even?" => fn -> Number.is_even?(number) end,
    "is_even_tco?" => fn -> Number.is_even_tco?(number) end,
    "is_even_tco_new_acc?" => fn -> Number.is_even_tco_new_acc?(number) end
  },
  warmup: 10,
  time: 10
)

# tobi@speedy ~/github/elixir_playground $ mix run bench/is_even.exs 
# Compiling 9 files (.ex)
# Generated elixir_playground app
# Erlang/OTP 19 [erts-8.1] [source] [64-bit] [smp:8:8] [async-threads:10] [hipe] [kernel-poll:false]
# Elixir 1.4.0
# Benchmark suite executing with the following configuration:
# warmup: 10.0s
# time: 10.0s
# parallel: 1
# inputs: none specified
# Estimated total run time: 60.0s
#
# Benchmarking is_even?...
# Benchmarking is_even_tco?...
# Benchmarking is_even_tco_new_acc?...
#
# Name                           ips        average  deviation         median
# is_even?                      9.70      103.06 ms    ±17.02%      100.88 ms
# is_even_tco_new_acc?          8.52      117.43 ms     ±0.21%      117.35 ms
# is_even_tco?                  8.48      117.91 ms     ±1.32%      117.50 ms
#
# Comparison:
# is_even?                      9.70
# is_even_tco_new_acc?          8.52 - 1.14x slower
# is_even_tco?                  8.48 - 1.14x slower
