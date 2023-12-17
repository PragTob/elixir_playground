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
    {Benchee.Formatters.HTML, path: "bench/output/task_no_task/index.html"}
  ]
)
