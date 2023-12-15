# From a conversation on #benchee slack with starbelly
# results between erlperf and benchee were different so do something very simple to minimize a chance for bugs:

alias Benchee.Benchmark.Collect.Time

payload = %{payload: :rand.bytes(1024)}

warmup_iterations = 1_000
measure_iterations = 10_000

binary_times =
  Task.async(fn ->
    # warmup
    Enum.map(1..warmup_iterations, fn _ ->
      {duration, _result} = Time.collect(fn -> :erlang.term_to_binary(payload) end)
      duration
    end)

    Enum.map(1..measure_iterations, fn _ ->
      {duration, _result} = Time.collect(fn -> :erlang.term_to_binary(payload) end)
      duration
    end)
  end)
  |> Task.await()

vec_times =
  Task.async(fn ->
    Enum.map(1..warmup_iterations, fn _ ->
      {duration, _result} = Time.collect(fn -> :erlang.term_to_iovec(payload) end)
      duration
    end)

    Enum.map(1..measure_iterations, fn _ ->
      {duration, _result} = Time.collect(fn -> :erlang.term_to_iovec(payload) end)
      duration
    end)
  end)
  |> Task.await()

IO.inspect(binary_times, label: "Binary times:")
IO.inspect(vec_times, label: "vex times:")

IO.inspect(Statistex.statistics(binary_times), label: "binary statistics:")
IO.inspect(Statistex.statistics(vec_times), label: "vec statistics:")

# tobi@qiqi:~/github/elixir_playground(main)$ mix run bench/dry_bin_vs_vex.exs
# Binary times:: [610, 220, 200, 180, 210, 190, 180, 170, 190, 180, 180, 190, 180, 180, 160, 170,
#  160, 170, 160, 170, 180, 170, 160, 170, 160, 180, 170, 170, 170, 160, 160, 170,
#  170, 220, 190, 180, 180, 190, 180, 190, 170, 180, 170, 180, 170, 180, 180, 180,
#  160, 170, ...]
# vex times:: [340, 230, 230, 210, 230, 250, 240, 230, 230, 210, 220, 210, 230, 220, 240, 220,
#  230, 220, 220, 210, 230, 210, 220, 240, 220, 220, 220, 220, 220, 210, 220, 210,
#  230, 230, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 280, 220, 220, 220,
#  220, 210, ...]
# binary statistics:: %Statistex{
#   total: 2062035,
#   average: 206.2035,
#   variance: 435866.3157193416,
#   standard_deviation: 660.2017235052796,
#   standard_deviation_ratio: 3.201699891152573,
#   median: 160.0,
#   percentiles: %{50 => 160.0},
#   frequency_distribution: %{
#     360 => 1,
#     2700 => 1,
#     270 => 5,
#     15240 => 1,
#     1390 => 2,
#     1960 => 1,
#     690 => 1,
#     16350 => 1,
#     170 => 2706,
#     14221 => 1,
#     13881 => 1,
#     890 => 1,
#     1381 => 1,
#     1500 => 4,
#     16151 => 1,
#     1460 => 6,
#     370 => 2,
#     1491 => 1,
#     171 => 14,
#     1520 => 5,
#     1370 => 5,
#     15900 => 1,
#     250 => 7,
#     191 => 2,
#     141 => 1,
#     610 => 1,
#     16551 => 1,
#     1540 => 2,
#     380 => 2,
#     1380 => 6,
#     510 => 1,
#     2660 => 1,
#     1770 => 1,
#     320 => 4,
#     710 => 1,
#     1450 => 2,
#     5411 => 1,
#     13760 => 1,
#     280 => 2,
#     1430 => 5,
#     400 => 1,
#     1360 => 2,
#     ...
#   },
#   mode: 160,
#   minimum: 140,
#   maximum: 17611,
#   sample_size: 10000
# }
# vec statistics:: %Statistex{
#   total: 2231722,
#   average: 223.1722,
#   variance: 4835.074854645349,
#   standard_deviation: 69.53470252072233,
#   standard_deviation_ratio: 0.3115742127412031,
#   median: 220.0,
#   percentiles: %{50 => 220.0},
#   frequency_distribution: %{
#     360 => 1,
#     270 => 41,
#     410 => 2,
#     370 => 1,
#     221 => 29,
#     250 => 184,
#     5211 => 1,
#     470 => 2,
#     380 => 1,
#     510 => 1,
#     320 => 2,
#     280 => 29,
#     211 => 6,
#     400 => 2,
#     230 => 1622,
#     390 => 1,
#     290 => 14,
#     341 => 1,
#     450 => 1,
#     271 => 1,
#     420 => 2,
#     350 => 2,
#     340 => 1,
#     330 => 2,
#     220 => 5226,
#     200 => 114,
#     480 => 1,
#     260 => 99,
#     310 => 7,
#     600 => 1,
#     251 => 4,
#     240 => 445,
#     300 => 8,
#     490 => 1,
#     201 => 1,
#     241 => 5,
#     231 => 14,
#     4830 => 1,
#     210 => 2124
#   },
#   mode: 220,
#   minimum: 200,
#   maximum: 5211,
#   sample_size: 10000
# }
