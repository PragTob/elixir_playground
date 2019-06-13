alias Board.{List1D, List2D, MapTuple, Tuple1D, Tuple2D}

board_list_2d = List2D.new()
board_list_1d = List1D.new()
board_map_tuple = MapTuple.new()
board_tuple_2d = Tuple2D.new()
board_tuple_1d = Tuple1D.new()

IO.puts("""

================= get(8,8) ====================

""")

Benchee.run(
  %{
    "get 8,8 List2D" => fn -> List2D.get(board_list_2d, 8, 8) end,
    "get 8,8 List1D" => fn -> List1D.get(board_list_1d, 8, 8) end,
    "get 8,8 MapTuple" => fn -> MapTuple.get(board_map_tuple, 8, 8) end,
    "get 8,8 Tuple2D" => fn -> Tuple2D.get(board_tuple_2d, 8, 8) end,
    "get 8,8 Tuple1D" => fn -> Tuple1D.get(board_tuple_1d, 8, 8) end
  },
  pre_check: true,
  time: 0.5,
  warmup: 0.5
)

IO.puts("""

================= get(0,0) ====================

""")

Benchee.run(
  %{
    "get 0,0 List2D" => fn -> List2D.get(board_list_2d, 0, 0) end,
    "get 0,0 List1D" => fn -> List1D.get(board_list_1d, 0, 0) end,
    "get 0,0 MapTuple" => fn -> MapTuple.get(board_map_tuple, 0, 0) end,
    "get 0,0 Tuple2D" => fn -> Tuple2D.get(board_tuple_2d, 0, 0) end,
    "get 0,0 Tuple1D" => fn -> Tuple1D.get(board_tuple_1d, 0, 0) end
  },
  pre_check: true,
  time: 0.5,
  warmup: 0.5
)

IO.puts("""

================= set(8,8) ====================

""")

Benchee.run(
  %{
    "set 8,8 List2D" => fn -> List2D.set(board_list_2d, 8, 8, :boing) end,
    "set 8,8 List1D" => fn -> List1D.set(board_list_1d, 8, 8, :boing) end,
    "set 8,8 MapTuple" => fn -> MapTuple.set(board_map_tuple, 8, 8, :boing) end,
    "set 8,8 Tuple2D" => fn -> Tuple2D.set(board_tuple_2d, 8, 8, :boing) end,
    "set 8,8 Tuple1D" => fn -> Tuple1D.set(board_tuple_1d, 8, 8, :boing) end
  },
  pre_check: true,
  time: 0.5,
  warmup: 0.5
)

IO.puts("""

================= set(0,0) ====================

""")

Benchee.run(
  %{
    "set 0,0 List2D" => fn -> List2D.set(board_list_2d, 0, 0, :boing) end,
    "set 0,0 List1D" => fn -> List1D.set(board_list_1d, 0, 0, :boing) end,
    "set 0,0 MapTuple" => fn -> MapTuple.set(board_map_tuple, 0, 0, :boing) end,
    "set 0,0 Tuple2D" => fn -> Tuple2D.set(board_tuple_2d, 0, 0, :boing) end,
    "set 0,0 Tuple1D" => fn -> Tuple1D.set(board_tuple_1d, 0, 0, :boing) end
  },
  pre_check: true,
  time: 0.5,
  warmup: 0.5
)
