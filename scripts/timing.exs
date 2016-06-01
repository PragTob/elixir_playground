:ok = :timer.start
start = :os.system_time :nano_seconds
finish = :os.system_time :nano_seconds
IO.puts "nanos measuring difference: #{finish - start}"

fun2 = fn -> Enum.map(Enum.to_list(1..100), fn(i) -> i * i end) end

{time, _} = :timer.tc fun2
IO.puts "first fun2 timer time: #{time}"

{time, _} = :timer.tc fun2
IO.puts "second fun2 timer time: #{time}"


{time, _return} = :timer.tc fn -> 0 end
IO.puts "Empty timer.tc #{time}"

func = fn -> Enum.to_list(1..5) end
{time2, _} = :timer.tc func
IO.puts ":timer.tc with small to_list: #{time2}"


start = :os.system_time :nano_seconds
func.()
finish = :os.system_time :nano_seconds
IO.puts "same func but sys time: #{finish - start}"

func = fn -> Enum.to_list(1..5) end
{time2, _} = :timer.tc func
IO.puts ":timer.tc with small to_list_2: #{time2}"
