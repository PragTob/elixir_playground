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
  warmup: 2,
  time: 5,
  formatters: [
    {Benchee.Formatters.Console, extended_statistics: true},
    {Benchee.Formatters.HTML, file: "bench/output/task_no_task_shorter/index.html", auto_open: false}
  ]
)

# NEW:
# Command being timed: "mix run bench/task_no_task_shorter.exs"
# User time (seconds): 80.13
# System time (seconds): 25.78
# Percent of CPU this job got: 122%
# Elapsed (wall clock) time (h:mm:ss or m:ss): 1:26.24
# Average shared text size (kbytes): 0
# Average unshared data size (kbytes): 0
# Average stack size (kbytes): 0
# Average total size (kbytes): 0
# Maximum resident set size (kbytes): 5509556
# Average resident set size (kbytes): 0
# Major (requiring I/O) page faults: 0
# Minor (reclaiming a frame) page faults: 14421794
# Voluntary context switches: 51452
# Involuntary context switches: 61274
# Swaps: 0
# File system inputs: 0
# File system outputs: 7256
# Socket messages sent: 0
# Socket messages received: 0
# Signals delivered: 0
# Page size (bytes): 4096
# Exit status: 0

# OLD:
# Command being timed: "mix run bench/task_no_task_shorter.exs"
# User time (seconds): 80.40
# System time (seconds): 26.39
# Percent of CPU this job got: 123%
# Elapsed (wall clock) time (h:mm:ss or m:ss): 1:26.54
# Average shared text size (kbytes): 0
# Average unshared data size (kbytes): 0
# Average stack size (kbytes): 0
# Average total size (kbytes): 0
# Maximum resident set size (kbytes): 5933356
# Average resident set size (kbytes): 0
# Major (requiring I/O) page faults: 2
# Minor (reclaiming a frame) page faults: 14972499
# Voluntary context switches: 37393
# Involuntary context switches: 37730
# Swaps: 0
# File system inputs: 0
# File system outputs: 7264
# Socket messages sent: 0
# Socket messages received: 0
# Signals delivered: 0
# Page size (bytes): 4096
# Exit status: 0
