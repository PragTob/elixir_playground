defmodule RateLimiter do
  @doc """
  Simple example for the elixir process anti patterns docs.
  """
  use GenServer

  def report_request(conn, pid) do
    GenServer.call(pid, {:report_request, conn})
  end

  @impl GenServer
  def init(init_arg) do
    {:ok, init_arg}
  end

  @impl GenServer
  def handle_call({:report_request, conn}, _from, state) do
    _ip = conn.remote_ip
    # actual logic irrelevant for example, but involves ip

    {:reply, :ok, state}
  end
end
