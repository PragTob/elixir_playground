map_fun = fn i -> i + 1 end

inputs = [
  {"Small (10 Thousand)", Enum.to_list(1..10_000)},
  {"Middle (100 Thousand)", Enum.to_list(1..100_000)},
  {"Big (1 Million)", Enum.to_list(1..1_000_000)},
  {"Bigger (5 Million)", Enum.to_list(1..5_000_000)},
  {"Giant (25 Million)", Enum.to_list(1..25_000_000)}
]

Benchee.run(
  %{
    "tail-recursive" => fn list -> MyMap.map_tco(list, map_fun) end,
    "stdlib map" => fn list -> Enum.map(list, map_fun) end,
    "body-recursive" => fn list -> MyMap.map_body(list, map_fun) end,
    "tail-rec arg-order" => fn list -> MyMap.map_tco_arg_order(list, map_fun) end
  },
  memory_time: 2,
  inputs: inputs,
  formatters: [
    Benchee.Formatters.Console,
    {Benchee.Formatters.HTML,
     file: "bench/output/tco_focussed_detailed_inputs_gc.html", auto_open: false}
  ],
  after_each: fn _ -> :erlang.garbage_collect() end
)

# tobi@speedy:~/github/elixir_playground(master)$ mix run bench/tco_blog_post_focussed_inputs.exs
# Operating System: Linux"
# CPU Information: Intel(R) Core(TM) i7-4790 CPU @ 3.60GHz
# Number of Available Cores: 8
# Available memory: 15.61 GB
# Elixir 1.6.4
# Erlang 20.3

# Benchmark suite executing with the following configuration:
# warmup: 2 s
# time: 5 s
# memory time: 2 s
# parallel: 1
# inputs: Big (1 Million), Bigger (5 Million), Middle (100 Thousand), Small (10 Thousand)
# Estimated total run time: 2.40 min

# Benchmarking body-recursive with input Big (1 Million)...
# Benchmarking body-recursive with input Bigger (5 Million)...
# Benchmarking body-recursive with input Middle (100 Thousand)...
# Benchmarking body-recursive with input Small (10 Thousand)...
# Benchmarking stdlib map with input Big (1 Million)...
# Benchmarking stdlib map with input Bigger (5 Million)...
# Benchmarking stdlib map with input Middle (100 Thousand)...
# Benchmarking stdlib map with input Small (10 Thousand)...
# Benchmarking tail-rec arg-order with input Big (1 Million)...
# Benchmarking tail-rec arg-order with input Bigger (5 Million)...
# Benchmarking tail-rec arg-order with input Middle (100 Thousand)...
# Benchmarking tail-rec arg-order with input Small (10 Thousand)...
# Benchmarking tail-recursive with input Big (1 Million)...
# Benchmarking tail-recursive with input Bigger (5 Million)...
# Benchmarking tail-recursive with input Middle (100 Thousand)...
# Benchmarking tail-recursive with input Small (10 Thousand)...

# ##### With input Big (1 Million) #####
# Name                         ips        average  deviation         median         99th %
# tail-rec arg-order         53.49       18.70 ms    ±22.70%       18.33 ms       24.16 ms
# body-recursive             47.14       21.21 ms    ±22.89%       20.68 ms       28.15 ms
# stdlib map                 46.46       21.52 ms    ±23.06%       21.05 ms       34.86 ms
# tail-recursive             33.55       29.80 ms    ±17.55%       30.26 ms       51.55 ms

# Comparison:
# tail-rec arg-order         53.49
# body-recursive             47.14 - 1.13x slower
# stdlib map                 46.46 - 1.15x slower
# tail-recursive             33.55 - 1.59x slower

# Extended statistics:

# Name                       minimum        maximum    sample size                     mode
# tail-rec arg-order        17.47 ms       86.37 ms            26517.70 ms, 17.73 ms, 18.32
# body-recursive            16.47 ms       79.96 ms            23320.17 ms, 20.88 ms, 20.78
# stdlib map                16.69 ms       80.45 ms            23020.50 ms, 20.57 ms, 17.35
# tail-recursive            23.85 ms       84.80 ms            166                 30.72 ms

# Memory usage statistics:

# Name                  Memory usage
# tail-rec arg-order        28.74 MB
# body-recursive            15.26 MB - 0.53x memory usage
# stdlib map                15.26 MB - 0.53x memory usage
# tail-recursive            28.74 MB - 1.00x memory usage

# **All measurements for memory usage were the same**

# ##### With input Bigger (5 Million) #####
# Name                         ips        average  deviation         median         99th %
# tail-rec arg-order          7.74      129.12 ms    ±24.38%      119.69 ms      233.75 ms
# tail-recursive              7.12      140.38 ms    ±19.83%      138.44 ms      242.14 ms
# stdlib map                  6.29      159.05 ms    ±13.77%      164.92 ms      212.35 ms
# body-recursive              6.24      160.14 ms    ±14.23%      164.66 ms      214.37 ms

# Comparison:
# tail-rec arg-order          7.74
# tail-recursive              7.12 - 1.09x slower
# stdlib map                  6.29 - 1.23x slower
# body-recursive              6.24 - 1.24x slower

# Extended statistics:

# Name                       minimum        maximum    sample size                     mode
# tail-rec arg-order        87.42 ms      233.75 ms             39                     None
# tail-recursive            95.46 ms      242.14 ms             36                     None
# stdlib map                84.67 ms      212.35 ms             32                     None
# body-recursive            85.14 ms      214.37 ms             31                     None

# Memory usage statistics:

# Name                  Memory usage
# tail-rec arg-order       150.15 MB
# tail-recursive           150.15 MB - 1.00x memory usage
# stdlib map                76.29 MB - 0.51x memory usage
# body-recursive            76.29 MB - 0.51x memory usage

# **All measurements for memory usage were the same**

# ##### With input Middle (100 Thousand) #####
# Name                         ips        average  deviation         median         99th %
# stdlib map                578.27        1.73 ms    ±62.47%        1.66 ms        2.14 ms
# body-recursive            572.69        1.75 ms    ±59.60%        1.67 ms        2.29 ms
# tail-rec arg-order        564.61        1.77 ms    ±41.54%        1.69 ms        2.58 ms
# tail-recursive            517.07        1.93 ms    ±39.75%        1.88 ms        2.35 ms

# Comparison:
# stdlib map                578.27
# body-recursive            572.69 - 1.01x slower
# tail-rec arg-order        564.61 - 1.02x slower
# tail-recursive            517.07 - 1.12x slower

# Extended statistics:

# Name                       minimum        maximum    sample size                     mode
# stdlib map                 1.63 ms       58.92 ms         2.86 K                  1.66 ms
# body-recursive             1.64 ms       55.92 ms         2.83 K                  1.67 ms
# tail-rec arg-order         1.62 ms       38.28 ms         2.80 K                  1.63 ms
# tail-recursive             1.81 ms       40.11 ms         2.56 K                  1.83 ms

# Memory usage statistics:

# Name                  Memory usage
# stdlib map                 1.53 MB
# body-recursive             1.53 MB - 1.00x memory usage
# tail-rec arg-order         1.80 MB - 1.18x memory usage
# tail-recursive             1.80 MB - 1.18x memory usage

# **All measurements for memory usage were the same**

# ##### With input Small (10 Thousand) #####
# Name                         ips        average  deviation         median         99th %
# stdlib map                6.01 K      166.28 μs   ±118.09%         163 μs         233 μs
# body-recursive            5.96 K      167.86 μs   ±171.25%         164 μs         216 μs
# tail-recursive            5.40 K      185.09 μs   ±106.59%         182 μs         289 μs
# tail-rec arg-order        4.96 K      201.42 μs   ±173.50%         190 μs         300 μs

# Comparison:
# stdlib map                6.01 K
# body-recursive            5.96 K - 1.01x slower
# tail-recursive            5.40 K - 1.11x slower
# tail-rec arg-order        4.96 K - 1.21x slower

# Extended statistics:

# Name                       minimum        maximum    sample size                     mode
# stdlib map                  161 μs       33753 μs        29.68 K                   163 μs
# body-recursive              161 μs       49162 μs        29.29 K                   164 μs
# tail-recursive              175 μs       31944 μs        26.67 K                   177 μs
# tail-rec arg-order          155 μs       52554 μs        24.41 K                   162 μs

# Memory usage statistics:

# Name                  Memory usage
# stdlib map               156.85 KB
# body-recursive           156.85 KB - 1.00x memory usage
# tail-recursive           291.46 KB - 1.86x memory usage
# tail-rec arg-order       291.46 KB - 1.86x memory usage
