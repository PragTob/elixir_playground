fun = fn i -> i * i end

inputs = %{
  "10" => Enum.to_list(1..10),
  "100" => Enum.to_list(1..100),
  "1_000" => Enum.to_list(1..1_000)
}

Benchee.run(
  %{
    "map" => fn list -> Enum.map(list, fun) end,
    "reduce" => fn list ->
      Enum.reduce(list, [], fn i, acc ->
        new_value = fun.(i)
        [new_value | acc]
      end)
    end
  },
  inputs: inputs
)
