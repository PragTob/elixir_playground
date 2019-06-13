board_implementations = [Board.List1D, Board.List2D, Board.MapTuple]

jobs =
  Enum.map(board_implementations, fn module ->
    benchmark_function = fn
      {board, {:get, x, y}} -> module.get(board, x, y)
    end

    before_each = fn input -> {module.new, input} end
    {to_string(module), {benchmark_function, before_each: before_each}}
  end)

inputs = [
  {"get 8,8", {:get, 8, 8}}
]

Benchee.run(
  jobs,
  inputs: inputs,
  pre_check: true,
  time: 0.5,
  warmup: 0.5
)
