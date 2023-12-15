port = Port.open({:spawn, "iex"}, [:binary, :exit_status])
receive do
  {^port, {:data, "iex(1)> "}} -> :ok
end
send(port, {self(), {:command, "\a"}})
# send(port, {self(), {:command, "q\n"}})
receive do
  {^port, {:exit_status, num}} -> num
after
  1_000 ->
    messages = :erlang.process_info(self(), :messages)
    IO.inspect(messages, label: "messages")
end
