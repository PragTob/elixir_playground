list = Enum.to_list(1..100_000_000)
MyMap.map_tco_arg_order(list, fn(i) -> i + 1 end) end
