tuple = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9}
list = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

Benchee.run(%{
  "tuple" => fn ->
    for i <- 0..9 do
      elem(tuple, i) + 1
    end
  end,
  "list" => fn ->
    Enum.each(list, fn e -> e + 1 end)
  end
})
