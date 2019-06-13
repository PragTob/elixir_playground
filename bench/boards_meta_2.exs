board_implementations = [Board.List1D, Board.List2D, Board.MapTuple]

before_each = fn module ->
  fn _ -> module.new end
end

get_8_8_jobs =
  Enum.map(board_implementations, fn module ->
    function = fn board -> module.get(board, 8, 8) end
    {module, {function, before_each: before_each.(module)}}
  end)

Benchee.run(
  get_8_8_jobs,
  pre_check: true,
  time: 0.5,
  warmup: 0.5
)
