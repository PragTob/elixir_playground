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
    # "sequential" => fn big_list ->
    #   uniques = Enum.uniq(big_list)
    #   frequencies = Enum.frequencies(big_list)
    #   shuffled = Enum.shuffle(big_list)

    #   [uniques, frequencies, shuffled]
    # end,
    "parallel" => fn big_list ->
      tasks = [
        Task.async(fn -> Enum.uniq(big_list) end),
        Task.async(fn -> Enum.frequencies(big_list) end),
        Task.async(fn -> Enum.shuffle(big_list) end)
      ]

      Task.await_many(tasks, :infinity)
    end
  },
  inputs: inputs,
  warmup: 15,
  time: 60,
  formatters: [
    {Benchee.Formatters.Console, extended_statistics: true},
    {Benchee.Formatters.HTML, file: "bench/output/task_no_task_2/index.html", auto_open: false}
  ]
)

# Operating System: Linux
# CPU Information: AMD Ryzen 9 5900X 12-Core Processor
# Number of Available Cores: 24
# Available memory: 31.25 GB
# Elixir 1.16.0-rc.1
# Erlang 26.1.2
# JIT enabled: true

# Benchmark suite executing with the following configuration:
# warmup: 15 s
# time: 1 min
# memory time: 0 ns
# reduction time: 0 ns
# parallel: 1
# inputs: 10k, 1M, 10M
# Estimated total run time: 7.50 min

# Benchmarking parallel with input 10k ...
# Benchmarking parallel with input 1M ...
# Benchmarking parallel with input 10M ...
# Benchmarking sequential with input 10k ...
# Benchmarking sequential with input 1M ...
# Benchmarking sequential with input 10M ...
# Calculating statistics...
# Formatting results...

# ##### With input 10k #####
# Name                 ips        average  deviation         median         99th %
# sequential        315.29        3.17 ms    ±20.76%        2.96 ms        5.44 ms
# parallel          156.77        6.38 ms    ±31.08%        6.11 ms       10.75 ms

# Comparison:
# sequential        315.29
# parallel          156.77 - 2.01x slower +3.21 ms

# Extended statistics:

# Name               minimum        maximum    sample size                     mode
# sequential         2.61 ms        7.84 ms        18.91 K         2.73 ms, 3.01 ms
# parallel           3.14 ms       11.99 ms         9.40 K4.80 ms, 4.87 ms, 8.93 ms

# ##### With input 1M #####
# Name                 ips        average  deviation         median         99th %
# sequential          1.14         0.87 s     ±7.16%         0.88 s         0.99 s
# parallel            0.94         1.07 s     ±3.65%         1.07 s         1.16 s

# Comparison:
# sequential          1.14
# parallel            0.94 - 1.22x slower +0.194 s

# Extended statistics:

# Name               minimum        maximum    sample size                     mode
# sequential          0.74 s         0.99 s             69                     None
# parallel            0.98 s         1.16 s             57                     None

# ##### With input 10M #####
# Name                 ips        average  deviation         median         99th %
# sequential        0.0896        11.17 s    ±10.79%        11.21 s        12.93 s
# parallel          0.0877        11.40 s     ±1.70%        11.37 s        11.66 s

# Comparison:
# sequential        0.0896
# parallel          0.0877 - 1.02x slower +0.23 s

# Extended statistics:

# Name               minimum        maximum    sample size                     mode
# sequential          9.22 s        12.93 s              6                     None
# parallel           11.16 s        11.66 s              6                     None
