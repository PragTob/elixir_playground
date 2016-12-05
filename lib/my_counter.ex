defmodule MyCounter do
  def inc(pid) do
    send(pid, :inc)
  end

  def dec(pid) do
    send(pid, :dec)
  end

  def val(pid, timeout \\ 5000) do
    unique_reference = make_ref()
    send pid, {:val, self(), unique_reference}

    receive do
      {^unique_reference, val} -> val
    after timeout -> exit(:timeout)
    end
  end

  def start_link(initial_value) do
    {:ok, spawn_link(fn -> listen(initial_value) end)}
  end

  defp listen(value) do
    receive do
      :inc -> listen value + 1
      :dec -> listen value - 1
      {:val, sender, reference} ->
        send sender, {reference, value}
        listen(value)
    end
  end
end
