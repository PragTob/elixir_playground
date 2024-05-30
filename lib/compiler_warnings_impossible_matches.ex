# Trying to show-case potential compiler warnings
#
# Some work (like matching any variable and then more specific ones underneath)
#
# tobi@frame:~/github/elixir_playground$ elixir -v
# Erlang/OTP 27 [erts-15.0] [source] [64-bit] [smp:16:16] [ds:16:16:10] [async-threads:1] [jit:ns]

# Elixir 1.18.0-dev (ed67d6b) (compiled with Erlang/OTP 27)

defmodule Matches do
  # does not warn although range can never match
  # first example taken from: https://www.reddit.com/r/elixir/comments/1cibtia/comment/l2cwqi2/
  def map_match(%{}), do: "map"
  def map_match(%Range{}), do: "range"

  def key_match(%{first: _first}), do: "map"
  def key_match(%Range{}), do: "range"

  # this one works/warns - kudos!
  # def struct_match(%{__struct__: Range}), do: "__struct__"
  # def struct_match(%Range{}), do: "struct"

  def atom_match(value) when is_atom(value), do: "atom"
  def atom_match(nil), do: "nil"
  def atom_match(value) when is_boolean(value), do: "bool"
end
