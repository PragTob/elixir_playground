alias Benchee.Formatters.{Console, HTML}
map_fun = fn i -> [i, i * i] end

inputs = %{
  "Medium" => Enum.to_list(1..1_000),
  "Bigger" => Enum.to_list(1..10_000),
  "Big" => Enum.to_list(1..100_000)
}

Benchee.run(
  %{
    "flat_map" => fn list -> Enum.flat_map(list, map_fun) end,
    "map.flatten" => fn list -> list |> Enum.map(map_fun) |> List.flatten() end
  },
  inputs: inputs,
  time: 40,
  warmup: 0,
  formatters: [&Console.output/1, &HTML.output/1],
  html: [file: "bench/output/flat_map_trigger.html"]
)
