IO.puts "starting"
list = Enum.to_list(1..1_000_000_00)

MyMap.map_tco(list, fn(i) -> i + 1 end)
