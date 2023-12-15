port = Port.open({:spawn, "iex"}, [:binary, :exit_status])

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
# Port.close(port)

# Fix: https://elixirforum.com/t/starting-shutting-down-iex-with-a-port-gracefully/60388/2?u=pragtob
send(port, {self(), {:command, "\a"}})
send(port, {self(), {:command, "q\n"}})

messages = :erlang.process_info(self(), :messages)
IO.inspect(messages, label: "messages")
# send(port, {self(), :close})
# receive do
#   {^port, :closed} -> :ok
# end
IO.puts("script finished")
