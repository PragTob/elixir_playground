inputs = %{
  "simple" => "2 5 +",
  "complex" => "15 7 1 1 + - / 3 * 2 1 1 + + -"
}

Benchee.run(
  %{
    PN => fn input -> PN.evaluate(input) end,
    PN2 => fn input -> PN2.evaluate(input) end
  },
  inputs: inputs,
  memory_time: 1
)

# tobi@speedy:~/github/elixir_playground(master)$ mix run bench/pn_bench.exs
# Operating System: Linux
# CPU Information: Intel(R) Core(TM) i7-4790 CPU @ 3.60GHz
# Number of Available Cores: 8
# Available memory: 15.58 GB
# Elixir 1.10.2
# Erlang 22.0

# Benchmark suite executing with the following configuration:
# warmup: 2 s
# time: 5 s
# memory time: 1 s
# parallel: 1
# inputs: complex, simple
# Estimated total run time: 32 s

# Benchmarking Elixir.PN with input complex...
# Benchmarking Elixir.PN with input simple...
# Benchmarking Elixir.PN2 with input complex...
# Benchmarking Elixir.PN2 with input simple...

# ##### With input complex #####
# Name                 ips        average  deviation         median         99th %
# Elixir.PN2      425.17 K        2.35 μs   ±492.59%        2.27 μs        3.24 μs
# Elixir.PN       407.33 K        2.45 μs   ±721.71%        2.33 μs        3.58 μs

# Comparison:
# Elixir.PN2      425.17 K
# Elixir.PN       407.33 K - 1.04x slower +0.103 μs

# Memory usage statistics:

# Name          Memory usage
# Elixir.PN2         1.58 KB
# Elixir.PN          2.02 KB - 1.28x memory usage +0.44 KB

# **All measurements for memory usage were the same**

# ##### With input simple #####
# Name                 ips        average  deviation         median         99th %
# Elixir.PN         1.45 M      688.30 ns  ±3721.86%         627 ns         973 ns
# Elixir.PN2        1.32 M      757.78 ns  ±1624.65%         700 ns        1121 ns

# Comparison:
# Elixir.PN         1.45 M
# Elixir.PN2        1.32 M - 1.10x slower +69.48 ns

# Memory usage statistics:

# Name          Memory usage
# Elixir.PN            256 B
# Elixir.PN2           304 B - 1.19x memory usage +48 B

# **All measurements for memory usage were the same**
