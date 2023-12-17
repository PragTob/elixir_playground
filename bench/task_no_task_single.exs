# Not terribly large, but passable
random_list = fn size, spread ->
  for _i <- 1..size, do: :rand.uniform(spread)
end

inputs = [
  {"10k", random_list.(10_000, 100)},
  {"1M", random_list.(1_000_000, 1_000)},
  {"10M", random_list.(10_000_000, 10_000)}
]

Benchee.run(
  %{
    "uniq" => fn big_list -> Enum.uniq(big_list) end,
    "frequencies" => fn big_list -> Enum.frequencies(big_list) end,
    "shuffle" => fn big_list -> Enum.shuffle(big_list) end,
    "sort" => fn big_list -> Enum.sort(big_list) end,
    "group_by mod 10" => fn big_list ->
      Enum.group_by(big_list, fn i -> Integer.mod(i, 10) end)
    end
  },
  inputs: inputs,
  warmup: 2,
  time: 5,
  formatters: [{Benchee.Formatters.Console, extended_statistics: true}]
)

# Operating System: Linux
# CPU Information: AMD Ryzen 9 5900X 12-Core Processor
# Number of Available Cores: 24
# Available memory: 31.25 GB
# Elixir 1.16.0-rc.1
# Erlang 25.3.2.7
# JIT enabled: true

# Benchmark suite executing with the following configuration:
# warmup: 2 s
# time: 5 s
# memory time: 0 ns
# reduction time: 0 ns
# parallel: 1
# inputs: 10k, 1M, 10M
# Estimated total run time: 1.75 min

# Benchmarking frequencies with input 10k ...
# Benchmarking frequencies with input 1M ...
# Benchmarking frequencies with input 10M ...
# Benchmarking group_by mod 10 with input 10k ...
# Benchmarking group_by mod 10 with input 1M ...
# Benchmarking group_by mod 10 with input 10M ...
# Benchmarking shuffle with input 10k ...
# Benchmarking shuffle with input 1M ...
# Benchmarking shuffle with input 10M ...
# Benchmarking sort with input 10k ...
# Benchmarking sort with input 1M ...
# Benchmarking sort with input 10M ...
# Benchmarking uniq with input 10k ...
# Benchmarking uniq with input 1M ...
# Benchmarking uniq with input 10M ...
# Calculating statistics...
# Formatting results...

# ##### With input 10k #####
# Name                      ips        average  deviation         median         99th %
# uniq                   6.87 K      145.59 μs   ±199.78%      144.74 μs      153.85 μs
# sort                   2.19 K      457.33 μs   ±208.87%      438.44 μs      544.30 μs
# group_by mod 10        1.18 K      848.41 μs   ±114.81%      761.98 μs     5461.24 μs
# frequencies            0.61 K     1633.93 μs    ±85.73%     1314.27 μs     6781.19 μs
# shuffle                0.46 K     2167.05 μs    ±52.25%     1912.46 μs     7176.92 μs

# Comparison:
# uniq                   6.87 K
# sort                   2.19 K - 3.14x slower +311.74 μs
# group_by mod 10        1.18 K - 5.83x slower +702.82 μs
# frequencies            0.61 K - 11.22x slower +1488.34 μs
# shuffle                0.46 K - 14.88x slower +2021.46 μs

# Extended statistics:

# Name                    minimum        maximum    sample size                     mode
# uniq                  131.15 μs    52581.92 μs        33.69 K                137.64 μs
# sort                  419.45 μs    86115.48 μs        10.77 K                427.14 μs
# group_by mod 10       319.58 μs    39299.55 μs         5.75 K                326.14 μs
# frequencies           598.75 μs    39996.47 μs         2.98 K               1290.40 μs
# shuffle              1847.86 μs    42940.24 μs         2.25 K1906.97 μs, 1871.73 μs, 1

# ##### With input 1M #####
# Name                      ips        average  deviation         median         99th %
# uniq                    68.19       14.67 ms     ±4.19%       14.63 ms       14.84 ms
# group_by mod 10          9.11      109.72 ms    ±37.76%      114.20 ms      230.05 ms
# sort                     7.92      126.32 ms    ±15.43%      123.35 ms      243.90 ms
# frequencies              4.10      243.84 ms     ±5.85%      245.78 ms      259.98 ms
# shuffle                  1.60      625.75 ms    ±11.52%      618.30 ms      749.93 ms

# Comparison:
# uniq                    68.19
# group_by mod 10          9.11 - 7.48x slower +95.05 ms
# sort                     7.92 - 8.61x slower +111.66 ms
# frequencies              4.10 - 16.63x slower +229.17 ms
# shuffle                  1.60 - 42.67x slower +611.08 ms

# Extended statistics:

# Name                    minimum        maximum    sample size                     mode
# uniq                   14.50 ms       25.83 ms            335                 14.61 ms
# group_by mod 10        42.96 ms      230.05 ms             45                     None
# sort                  109.93 ms      243.90 ms             39                     None
# frequencies           194.34 ms      259.98 ms             20                     None
# shuffle               538.92 ms      749.93 ms              8                     None

# ##### With input 10M #####
# Name                      ips        average  deviation         median         99th %
# uniq                     4.66         0.21 s     ±0.80%         0.21 s         0.22 s
# group_by mod 10          1.05         0.95 s    ±26.14%         0.94 s         1.29 s
# sort                     0.65         1.54 s    ±24.50%         1.40 s         2.10 s
# frequencies              0.30         3.38 s     ±3.09%         3.38 s         3.45 s
# shuffle                 0.135         7.40 s     ±0.00%         7.40 s         7.40 s

# Comparison:
# uniq                     4.66
# group_by mod 10          1.05 - 4.43x slower +0.74 s
# sort                     0.65 - 7.20x slower +1.33 s
# frequencies              0.30 - 15.76x slower +3.17 s
# shuffle                 0.135 - 34.52x slower +7.19 s

# Extended statistics:

# Name                    minimum        maximum    sample size                     mode
# uniq                     0.21 s         0.22 s             23                     None
# group_by mod 10          0.67 s         1.29 s              6                     None
# sort                     1.28 s         2.10 s              4                     None
# frequencies              3.31 s         3.45 s              2                     None
# shuffle                  7.40 s         7.40 s              1                     None
