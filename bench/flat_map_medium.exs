list = Enum.to_list(1..200)
map_fun = fn(i) -> [i, i * i] end

Benchee.run(%{time: 8}, %{
  "flat_map"         => fn -> Enum.flat_map(list, map_fun) end,
  "map.flatten"      => fn -> list |> Enum.map(map_fun) |> List.flatten end,
  "flat_map v1"      => fn -> FlatMap.flat_map(list, map_fun) end,
  "flat_map_list v2" => fn -> FlatMap.flat_map_list(list, map_fun) end,
  ":lists.flatmap"   => fn -> :lists.flatmap(map_fun, list) end
})
