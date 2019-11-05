defmodule Bark do
  @callback bark() :: String.t()
end

defmodule BarkImpl do
  @behaviour Bark

  @impl Bark
  def bark(), do: "wooofff"
end
