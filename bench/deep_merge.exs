base_map = (0..50)
           |> Enum.zip(300..350)
           |> Enum.into(%{})

orig = Map.merge base_map, %{150 => %{1 => 1, 2 => 2}, 155 => %{y: :x}, 170 => %{"foo" => "bar"}, z: %{ x: 4, y: %{a: 1, b: %{c: 2}, d: %{"hey" => "ho"}}}, a: %{b: %{c: %{a: 99, d: "foo", e: 2}}, m: [33], i: 99, y: "bar"}, b: %{y: [23, 87]}, z: %{xy: %{y: :x}}}
new = Map.merge base_map, %{150 => %{3 => 3}, 160 => %{a: "b"}, z: %{ xui: [44], y: %{b: %{c: 77, d: 55}, d: %{"ho" => "hey", "du" => "nu", "hey" => "ha"}}}, a: %{b: %{c: %{a: 1, b: 2, d: "bar"}}, m: 12, i: 102}, b: %{ x: 65, y: [23]}, z: %{ xy: %{x: :y}}}

simple_merge_fun = fn(_key, _base, override) -> override end

Benchee.run %{
  "Map.merge/2"  => fn -> Map.merge orig, new end,
  "Map.merge/3"  => fn -> Map.merge orig, new, simple_merge_fun end,
  "deep_merge/2" => fn -> DeepMerge.deep_merge orig, new end,
  "deep_merge/3" => fn -> DeepMerge.deep_merge orig, new, simple_merge_fun end
}


# tobi@happy ~/github/elixir_playground $ mix run bench/deep_merge.exs
# Erlang/OTP 19 [erts-8.0.2] [source-753b9b9] [64-bit] [smp:8:8] [async-threads:10] [hipe] [kernel-poll:false]
# Elixir 1.3.0
# Benchmark suite executing with the following configuration:
# warmup: 2.0s
# time: 5.0s
# parallel: 1
# Estimated total run time: 21.0s
#
# Benchmarking Map.merge/2...
# Warning: The function you are trying to benchmark is super fast, making time measures unreliable!
# Benchee won't measure individual runs but rather run it a couple of times and report the average back. Measures will still be correct, but the overhead of running it n times goes into the measurement. Also statistical results aren't as good, as they are based on averages now. If possible, increase the input size so that an individual run takes more than 10μs
#
# Benchmarking deep_merge/2...
# Warning: The function you are trying to benchmark is super fast, making time measures unreliable!
# Benchee won't measure individual runs but rather run it a couple of times and report the average back. Measures will still be correct, but the overhead of running it n times goes into the measurement. Also statistical results aren't as good, as they are based on averages now. If possible, increase the input size so that an individual run takes more than 10μs
#
# Benchmarking deep_merge/3...
# Warning: The function you are trying to benchmark is super fast, making time measures unreliable!
# Benchee won't measure individual runs but rather run it a couple of times and report the average back. Measures will still be correct, but the overhead of running it n times goes into the measurement. Also statistical results aren't as good, as they are based on averages now. If possible, increase the input size so that an individual run takes more than 10μs
#
#
# Name                   ips        average    deviation         median
# Map.merge/2    18104059.78      0.0552 μs     (±7.82%)      0.0550 μs
# deep_merge/2     539900.92        1.85 μs    (±59.57%)        1.70 μs
# deep_merge/3     524389.39        1.91 μs    (±67.02%)        1.70 μs
#
# Comparison:
# Map.merge/2    18104059.78
# deep_merge/2     539900.92 - 33.53x slower
# deep_merge/3     524389.39 - 34.52x slower
