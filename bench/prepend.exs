Benchee.run(
  [
    {"ex_cons", fn -> [{:foo, :bar}] ++ [1, 2, 3, 4, 5, 6] end},
    {"ex_plus", fn -> [{:foo, :bar} | [1, 2, 3, 4, 5, 6]] end}
  ],
  time: 2,
  warmup: 1,
  memory_time: 0
)
