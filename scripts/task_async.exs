defmodule Geocoder do
  def geocode(address), do: IO.puts address # such fake many wow
end

pick_up = "Some street"
drop_off = "Other Street"


[pick_up, drop_off]
|> Enum.map(fn(address) -> Task.async(fn -> Geocoder.geocode(address) end) end)
|> Enum.map(&Task.await/1)