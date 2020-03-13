# list = Enum.to_list(1..10_000)
map_fun = fn i -> [i, i * i] end

Benchee.run(
  %{
    "flat_map" => fn list -> Enum.flat_map(list, map_fun) end,
    "map.flatten" => fn list -> list |> Enum.map(map_fun) |> List.flatten() end
  },
  memory_time: 2,
  inputs: %{"lol" => Enum.to_list(1..10_000)},
  formatters: [{Benchee.Formatters.HTML, file: "bench/output/map_inputs_with_inputs.html"}]
)
