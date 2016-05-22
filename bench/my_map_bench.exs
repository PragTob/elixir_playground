defmodule MyMapBench do
  use Benchfella

  @list Enum.to_list(1..10_000)

  bench "map with TCO reverse" do
    MyMap.map(@list, fn(i) -> i + 1 end)
  end

  bench "map with TCO and ++" do
    MyMap.map2(@list, fn(i) -> i + 1 end)
  end

  bench "map simple without TCO" do
    MyMap.map3(@list, fn(i) -> i + 1 end)
  end

end
