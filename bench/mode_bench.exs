inputs = %{
  "thousand" => Enum.map(1..1000, fn(_) -> :rand.uniform(500) end),
  "100k"     => Enum.map(1..100_000, fn(_) -> :rand.uniform(3000) end),
  "5M"       => Enum.map(1..5_000_000, fn(_) -> :rand.uniform(100_000) end)
}

Benchee.run %{
  "basic mode"    => fn(input) -> Statistics.compute_mode(input) end,
  "advanced mode" => fn(input) -> Statistics.compute_mode_advanced(input) end
}, inputs: inputs
