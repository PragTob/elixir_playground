# Just got curios to what degree things are affected with this optimization
# i.e. is the compiled `Enum.map` module fine if we pass it a function from
# the top level
#
# Where interestingly, none of these seem to be affected.

defmodule FullCompiled do
  def map(list) do
    map_fn = fn x -> x * x end

    Enum.map(list, map_fn)
  end
end

list = Enum.to_list(1..10_000)
map_fn = fn x -> x * x end

Benchee.run(%{
  "normal map" => fn -> Enum.map(list, map_fn) end,
  "for comprhension" => fn -> for x <- list, do: x * x end,
  "full compiled map" => fn -> FullCompiled.map(list) end
})
