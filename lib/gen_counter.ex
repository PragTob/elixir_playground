defmodule GenCounter do
  use GenServer

  def inc(pid) do
    GenServer.cast(pid, :inc)
  end

  def dec(pid) do
    GenServer.cast(pid, :dec)
  end

  def val(pid, _timeout \\ 5000) do
    GenServer.call(pid, :val)
  end

  def start_link(initial_value) do
    GenServer.start_link(__MODULE__, initial_value)
  end

  def init(initial_value) do
    {:ok, initial_value}
  end

  def handle_cast(:inc, value) do
    {:noreply, value + 1}
  end

  def handle_cast(:dec, value) do
    {:noreply, value - 1}
  end

  def handle_call(:val, _from, value) do
    {:reply, value, value}
  end
end
