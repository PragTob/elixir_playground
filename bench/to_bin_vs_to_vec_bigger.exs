# from starbelly in #benchee slack

inputs = %{
  "10 240" => %{payload: :rand.bytes(10_240)},
  "102 400" => %{payload: :rand.bytes(102_400)},
  "1 024 000" => %{payload: :rand.bytes(1_024_000)}
}

Benchee.run(
  %{
    "term_to_iovec" => fn payload -> :erlang.term_to_iovec(payload) end,
    "term_to_binary" => fn payload -> :erlang.term_to_binary(payload) end
  },
  time: 3,
  warmup: 2,
  formatters: [
    {Benchee.Formatters.Console, extended_statistics: true},
    {Benchee.Formatters.HTML, file: "bench/output/binvec.html"}
  ],
  inputs: inputs
  # after_each: fn _ -> :erlang.garbage_collect() end
)

# tobi@qiqi:~/github/elixir_playground(main)$ mix run bench/to_bin_vs_to_vec_bigger.exs
# Operating System: Linux
# CPU Information: AMD Ryzen 9 5900X 12-Core Processor
# Number of Available Cores: 24
# Available memory: 31.25 GB
# Elixir 1.16.0-rc.1
# Erlang 26.1.2

# Benchmark suite executing with the following configuration:
# warmup: 2 s
# time: 3 s
# memory time: 0 ns
# reduction time: 0 ns
# parallel: 1
# inputs: 1 024 000, 10 240, 102 400
# Estimated total run time: 30 s

# Benchmarking term_to_binary with input 1 024 000 ...
# Benchmarking term_to_binary with input 10 240 ...
# Benchmarking term_to_binary with input 102 400 ...
# Benchmarking term_to_iovec with input 1 024 000 ...
# Benchmarking term_to_iovec with input 10 240 ...
# Benchmarking term_to_iovec with input 102 400 ...

# ##### With input 1 024 000 #####
# Name                     ips        average  deviation         median         99th %
# term_to_iovec         3.34 M        0.30 μs  ±4195.93%        0.25 μs        1.49 μs
# term_to_binary     0.00500 M      200.11 μs    ±11.58%      199.33 μs      264.51 μs

# Comparison:
# term_to_iovec         3.34 M
# term_to_binary     0.00500 M - 668.62x slower +199.81 μs

# Extended statistics:

# Name                   minimum        maximum    sample size                     mode
# term_to_iovec          0.22 μs    12493.40 μs         3.30 M                  0.25 μs
# term_to_binary       174.42 μs     1659.88 μs        14.96 K                199.22 μs

# ##### With input 10 240 #####
# Name                     ips        average  deviation         median         99th %
# term_to_iovec         3.15 M      317.32 ns  ±6524.97%         250 ns        1530 ns
# term_to_binary        2.38 M      420.66 ns  ±8836.66%         310 ns        1910 ns

# Comparison:
# term_to_iovec         3.15 M
# term_to_binary        2.38 M - 1.33x slower +103.33 ns

# Extended statistics:

# Name                   minimum        maximum    sample size                     mode
# term_to_iovec           210 ns    21058833 ns         3.16 M                   250 ns
# term_to_binary          260 ns    32256941 ns         4.79 M                   300 ns

# ##### With input 102 400 #####
# Name                     ips        average  deviation         median         99th %
# term_to_iovec         3.11 M        0.32 μs  ±6139.43%        0.25 μs        1.52 μs
# term_to_binary        0.41 M        2.42 μs  ±1705.47%        2.12 μs        3.43 μs

# Comparison:
# term_to_iovec         3.11 M
# term_to_binary        0.41 M - 7.51x slower +2.09 μs

# Extended statistics:

# Name                   minimum        maximum    sample size                     mode
# term_to_iovec          0.21 μs    18417.55 μs         2.92 M                  0.25 μs
# term_to_binary         1.74 μs    21003.76 μs         1.11 M                  1.87 μs
