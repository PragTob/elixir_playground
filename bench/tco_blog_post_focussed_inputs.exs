map_fun = fn(i) -> i + 1 end
inputs = %{
  "Small (1 Thousand)"    => Enum.to_list(1..1_000),
  "Middle (100 Thousand)" => Enum.to_list(1..100_000),
  "Big (10 Million)"      => Enum.to_list(1..10_000_000),
}

Benchee.run %{
  "map tail-recursive" =>
    fn(list) -> MyMap.map_tco(list, map_fun) end,
  "stdlib map" =>
    fn(list) -> Enum.map(list, map_fun) end,
  "map simple body-recursive" =>
    fn(list) -> MyMap.map_body(list, map_fun) end,
  "map tail-recursive different argument order" =>
    fn(list) -> MyMap.map_tco_arg_order(list, map_fun) end
}, time: 15, warmup: 5, inputs: inputs
