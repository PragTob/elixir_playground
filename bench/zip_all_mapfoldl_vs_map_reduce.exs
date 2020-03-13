one_hundred = Enum.to_list(1..100)

inputs = %{
  "100, 100, 100" => [one_hundred, one_hundred, one_hundred],
  "1000, 2000, 1500" => [Enum.to_list(1..1000), Enum.to_list(1..2000), Enum.to_list(1..1500)],
  "400 * 100" => Enum.map(1..400, fn _ -> one_hundred end)
}

Benchee.run(
  %{
    "zip with mapfoldl" => fn lists -> Zip.all(lists) end,
    "zip with map_reduce" => fn lists -> Zip.all_map_reduce(lists) end
  },
  inputs: inputs
)

# ##### With input 100, 100, 100 #####
# Name                          ips        average  deviation         median         99th %
# zip with map_reduce       58.17 K       17.19 μs    ±67.47%          16 μs          55 μs
# zip with mapfoldl         56.46 K       17.71 μs    ±66.27%          16 μs          48 μs

# Comparison: 
# zip with map_reduce       58.17 K
# zip with mapfoldl         56.46 K - 1.03x slower

# ##### With input 1000, 2000, 1500 #####
# Name                          ips        average  deviation         median         99th %
# zip with map_reduce        2.65 K      377.34 μs    ±11.20%         369 μs         529 μs
# zip with mapfoldl          2.54 K      394.46 μs    ±11.71%         387 μs      585.82 μs

# Comparison: 
# zip with map_reduce        2.65 K
# zip with mapfoldl          2.54 K - 1.05x slower

# ##### With input 400 * 100 #####
# Name                          ips        average  deviation         median         99th %
# zip with map_reduce        653.46        1.53 ms    ±21.94%        1.41 ms        3.01 ms
# zip with mapfoldl          614.83        1.63 ms    ±20.23%        1.51 ms        3.08 ms

# Comparison: 
# zip with map_reduce        653.46
# zip with mapfoldl          614.83 - 1.06x slower
