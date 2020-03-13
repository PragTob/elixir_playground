defmodule Geocoder do
  # such fake many wow
  def geocode(address), do: IO.puts(address)
end

pick_up = "Some street"
drop_off = "Other Street"

[pick_up, drop_off]
|> Enum.map(fn address -> Task.async(&geocode/1) end)
|> Enum.map(&Task.await/1)
