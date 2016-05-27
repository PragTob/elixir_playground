IO.puts "starting"
list = Enum.to_list(1..1_000_000_00)

IO.puts "map3"
MyMap.map3 list, fn(i) -> i + 1 end

IO.puts "map"
MyMap.map list, fn(i) -> i + 1 end
IO.puts "map2"
MyMap.map2 list, fn(i) -> i + 1 end
