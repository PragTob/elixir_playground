# from starbelly in #benchee slack

payload = %{payload: :rand.bytes(1024)}

Benchee.run(
  %{
    "term_to_iovec" => fn -> :erlang.term_to_iovec(payload) end,
    "term_to_binary" => fn -> :erlang.term_to_binary(payload) end
  },
  time: 1,
  warmup: 0.1,
  memory_time: 1,
  formatters: [
    {Benchee.Formatters.Console, extended_statistics: true},
    {Benchee.Formatters.HTML, file: "bench/output/binvec.html"}
  ],
  after_each: fn _ -> :erlang.garbage_collect() end
)

# tobi@qiqi:~/github/elixir_playground(main)$ mix run bench/to_bin_vs_to_vex.exs
# Operating System: Linux
# CPU Information: AMD Ryzen 9 5900X 12-Core Processor
# Number of Available Cores: 24
# Available memory: 31.25 GB
# Elixir 1.16.0-rc.1
# Erlang 26.1.2

# Benchmark suite executing with the following configuration:
# warmup: 100 ms
# time: 1 s
# memory time: 1 s
# reduction time: 0 ns
# parallel: 1
# inputs: none specified
# Estimated total run time: 4.20 s

# Benchmarking term_to_binary ...
# Benchmarking term_to_iovec ...

# Name                     ips        average  deviation         median         99th %
# term_to_binary        3.77 M      265.47 ns    ±38.22%         260 ns         570 ns
# term_to_iovec         2.63 M      379.99 ns    ±55.51%         350 ns        1300 ns

# Comparison:
# term_to_binary        3.77 M
# term_to_iovec         2.63 M - 1.43x slower +114.52 ns

# Extended statistics:

# Name                   minimum        maximum    sample size                     mode
# term_to_binary          180 ns        4040 ns        23.44 K                   200 ns
# term_to_iovec           240 ns        9570 ns        23.36 K                   270 ns

# Memory usage statistics:

# Name              Memory usage
# term_to_binary            48 B
# term_to_iovec             80 B - 1.67x memory usage +32 B
