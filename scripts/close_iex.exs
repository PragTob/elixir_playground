port = Port.open({:spawn, "iex"}, [:binary])

# wait for startup
receive do
  {^port, {:data, "iex(1)> "}} -> :ok
end

# attemtps at closing iex in the port
# send(port, {:command, "^C"})
# send(port, {:command, "^C"})
# send(port, {:command, "^\\"})
# port_info = port |> Port.info() |> IO.inspect()
# os_pid = Access.get(port_info, :os_pid)
# System.cmd("kill", [to_string(os_pid)])

# attempts at closing just the port
Port.close(port)
# send(port, {self(), :close})
# receive do
#   {^port, :closed} -> :ok
# end
IO.puts("script finished")
