# Taken from https://github.com/sabiwara/elixir_benches/blob/main/bench/compiler_optimizations.exs
# See: https://github.com/bencheeorg/benchee/issues/406#issuecomment-1853506094
# Results further down are my own

list = Enum.to_list(1..10_000)

defmodule Compiled do
  def comprehension(list) do
    for x <- list, rem(x, 2) == 1, do: x + 1
  end
end

# Top level definitions used to be slower than module definitions.
# These were due to disabled compiler optimizations (no_bool_opt, no_ssa_opt)
# and have been fixed from elixir 1.16.0-rc.1:
# https://github.com/elixir-lang/elixir/commit/aabe46536e021da88de39bc5c82c90d97b0604ec#diff-1f4ed234972cb699fe6dc400f3bbf57f72919ef587ba6b1a43441c8b784b0cfb

Benchee.run(%{
  "module (optimized)" => fn -> Compiled.comprehension(list) end,
  "top_level (non-optimized)" => fn -> for x <- list, rem(x, 2) == 1, do: x + 1 end
})

# Behavior was fixed in 1.16.0-rc.1, allegedly introduced in 1.14.0 - order of benchmarks below to proof it :)
#
# ---------------- 1.13.4 -------------------------------
#
# seems to _mostly_ work albeit a bit slower
#
# tobi@qiqi:~/github/elixir_playground(main)$ mix run bench/top_level_functions.exs
# Operating System: Linux
# CPU Information: AMD Ryzen 9 5900X 12-Core Processor
# Number of Available Cores: 24
# Available memory: 31.25 GB
# Elixir 1.13.4
# Erlang 25.3.2.7

# Benchmark suite executing with the following configuration:
# warmup: 2 s
# time: 5 s
# memory time: 0 ns
# reduction time: 0 ns
# parallel: 1
# inputs: none specified
# Estimated total run time: 14 s

# Benchmarking module (optimized) ...
# Benchmarking top_level (non-optimized) ...

# Name                                ips        average  deviation         median         99th %
# module (optimized)               1.55 M      647.13 ns  ±5780.24%         550 ns         960 ns
# top_level (non-optimized)        1.42 M      703.80 ns  ±3472.07%         610 ns        1000 ns

# Comparison:
# module (optimized)               1.55 M
# top_level (non-optimized)        1.42 M - 1.09x slower +56.66 ns
#
#
# ---------------- 1.14.0 -------------------------------
#
# Operating System: Linux
# CPU Information: AMD Ryzen 9 5900X 12-Core Processor
# Number of Available Cores: 24
# Available memory: 31.25 GB
# Elixir 1.14.0
# Erlang 25.3.2.7

# Benchmark suite executing with the following configuration:
# warmup: 2 s
# time: 5 s
# memory time: 0 ns
# reduction time: 0 ns
# parallel: 1
# inputs: none specified
# Estimated total run time: 14 s

# Benchmarking module (optimized) ...
# Benchmarking top_level (non-optimized) ...

# Name                                ips        average  deviation         median         99th %
# module (optimized)               1.62 M      617.01 ns  ±5809.98%         510 ns         950 ns
# top_level (non-optimized)        1.11 M      900.02 ns  ±5646.23%         770 ns        1430 ns

# Comparison:
# module (optimized)               1.62 M
# top_level (non-optimized)        1.11 M - 1.46x slower +283.01 ns

#
# ---------------- 1.16.0-rc.0 -------------------------------
# Operating System: Linux
# CPU Information: AMD Ryzen 9 5900X 12-Core Processor
# Number of Available Cores: 24
# Available memory: 31.25 GB
# Elixir 1.16.0-rc.0
# Erlang 26.1.2

# Benchmark suite executing with the following configuration:
# warmup: 2 s
# time: 5 s
# memory time: 0 ns
# reduction time: 0 ns
# parallel: 1
# inputs: none specified
# Estimated total run time: 14 s

# Benchmarking module (optimized) ...

# 11:42:31.189 [debug] Tzdata polling for update.

# 11:42:31.923 [debug] Tzdata polling shows the loaded tz database is up to date.
# Benchmarking top_level (non-optimized) ...

# Name                                ips        average  deviation         median         99th %
# module (optimized)               1.77 M      566.02 ns  ±7532.11%         460 ns        1030 ns
# top_level (non-optimized)        1.12 M      889.61 ns  ±5153.66%         780 ns        1290 ns

# Comparison:
# module (optimized)               1.77 M
# top_level (non-optimized)        1.12 M - 1.57x slower +323.59 ns
#
#
# ---------------- 1.16.0-rc.1 -------------------------------
# Operating System: Linux
# CPU Information: AMD Ryzen 9 5900X 12-Core Processor
# Number of Available Cores: 24
# Available memory: 31.25 GB
# Elixir 1.16.0-rc.1
# Erlang 26.1.2

# Benchmark suite executing with the following configuration:
# warmup: 2 s
# time: 5 s
# memory time: 0 ns
# reduction time: 0 ns
# parallel: 1
# inputs: none specified
# Estimated total run time: 14 s

# Benchmarking module (optimized) ...
# Benchmarking top_level (non-optimized) ...

# Name                                ips        average  deviation         median         99th %
# module (optimized)               1.78 M      560.52 ns  ±7533.32%         460 ns         760 ns
# top_level (non-optimized)        1.76 M      568.27 ns  ±6299.74%         450 ns         800 ns

# Comparison:
# module (optimized)               1.78 M
