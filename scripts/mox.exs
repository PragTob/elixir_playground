defmodule Bark do
  @callback bark() :: String.t()
end

defmodule BarkImpl do
  @behaviour Bark

  @impl Bark
  def bark(), do: "wooofff"
end

Application.ensure_all_started(:mox)

import Mox

defmock(BarkMock, for: Bark)
stub_with(BarkMock, BarkImpl)

IO.puts(BarkMock.bark())

expect(BarkMock, :bark, fn -> "chirp chirp" end)

IO.puts(BarkMock.bark())
IO.puts(BarkMock.bark())
IO.puts(BarkMock.bark())
