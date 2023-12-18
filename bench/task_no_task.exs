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
    "sequential" => fn big_list ->
      uniques = Enum.uniq(big_list)
      frequencies = Enum.frequencies(big_list)
      shuffled = Enum.shuffle(big_list)

      [uniques, frequencies, shuffled]
    end,
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
    {Benchee.Formatters.HTML, file: "bench/output/task_no_task/index.html", auto_open: false}
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
# sequential        259.28        3.86 ms    ±48.36%        3.94 ms        9.76 ms
# parallel          225.97        4.43 ms    ±27.67%        4.30 ms        5.67 ms

# Comparison:
# sequential        259.28
# parallel          225.97 - 1.15x slower +0.57 ms

# Extended statistics:

# Name               minimum        maximum    sample size                     mode
# sequential         2.23 ms       39.73 ms        15.52 K         2.27 ms, 2.28 ms
# parallel           2.98 ms      124.92 ms        13.53 K4.35 ms, 4.21 ms, 4.94 ms

# ##### With input 1M #####
# Name                 ips        average  deviation         median         99th %
# sequential          1.41         0.71 s    ±12.48%         0.70 s         0.99 s
# parallel            0.95         1.06 s     ±4.09%         1.05 s         1.26 s

# Comparison:
# sequential          1.41
# parallel            0.95 - 1.48x slower +0.34 s

# Extended statistics:

# Name               minimum        maximum    sample size                     mode
# sequential          0.54 s         0.99 s             85                     None
# parallel            0.97 s         1.26 s             57                     None

# ##### With input 10M #####
# Name                 ips        average  deviation         median         99th %
# sequential        0.0932        10.73 s     ±7.54%        11.00 s        11.28 s
# parallel          0.0877        11.40 s     ±1.45%        11.41 s        11.61 s

# Comparison:
# sequential        0.0932
# parallel          0.0877 - 1.06x slower +0.66 s

# Extended statistics:

# Name               minimum        maximum    sample size                     mode
# sequential          9.16 s        11.28 s              6                     None
# parallel           11.19 s        11.61 s              6                     None
# Generated bench/output/task_no_task/index.html
# Generated bench/output/task_no_task/index_10m_comparison.html
# Generated bench/output/task_no_task/index_10m_sequential.html
# Generated bench/output/task_no_task/index_10m_parallel.html
# Generated bench/output/task_no_task/index_10k_comparison.html
# Generated bench/output/task_no_task/index_10k_sequential.html
# Generated bench/output/task_no_task/index_10k_parallel.html
# Generated bench/output/task_no_task/index_1m_comparison.html
# Generated bench/output/task_no_task/index_1m_sequential.html
# Generated bench/output/task_no_task/index_1m_parallel.html
