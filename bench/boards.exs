alias Board.{List1D, List2D, MapTuple, MapTupleFull, Tuple1D, Tuple2D}

board_list_2d = List2D.new()
board_list_1d = List1D.new()
board_map_tuple = MapTuple.new()
board_map_tuple_full = MapTupleFull.new()
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
    "get 8,8 MapTupleFull" => fn -> MapTupleFull.get(board_map_tuple, 8, 8) end,
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
    "get 0,0 MapTupleFull" => fn -> MapTupleFull.get(board_map_tuple_full, 0, 0) end,
    "get 0,0 Tuple2D" => fn -> Tuple2D.get(board_tuple_2d, 0, 0) end,
    "get 0,0 Tuple1D" => fn -> Tuple1D.get(board_tuple_1d, 0, 0) end
  },
  pre_check: true,
  time: 0.5,
  warmup: 0.5,
  print: [benchmarking: false, configuration: false]
)

IO.puts("""

================= set(8,8) ====================

""")

Benchee.run(
  %{
    "set 8,8 List2D" => fn -> List2D.set(board_list_2d, 8, 8, :boing) end,
    "set 8,8 List1D" => fn -> List1D.set(board_list_1d, 8, 8, :boing) end,
    "set 8,8 MapTuple" => fn -> MapTuple.set(board_map_tuple, 8, 8, :boing) end,
    "set 8,8 MapTupleFull" => fn -> MapTupleFull.set(board_map_tuple_full, 8, 8, :boing) end,
    "set 8,8 Tuple2D" => fn -> Tuple2D.set(board_tuple_2d, 8, 8, :boing) end,
    "set 8,8 Tuple1D" => fn -> Tuple1D.set(board_tuple_1d, 8, 8, :boing) end
  },
  pre_check: true,
  time: 0.5,
  warmup: 0.5,
  print: [benchmarking: false, configuration: false]
)

IO.puts("""

================= set(0,0) ====================

""")

Benchee.run(
  %{
    "set 0,0 List2D" => fn -> List2D.set(board_list_2d, 0, 0, :boing) end,
    "set 0,0 List1D" => fn -> List1D.set(board_list_1d, 0, 0, :boing) end,
    "set 0,0 MapTuple" => fn -> MapTuple.set(board_map_tuple, 0, 0, :boing) end,
    "set 0,0 MapTupleFull" => fn -> MapTupleFull.set(board_map_tuple_full, 0, 0, :boing) end,
    "set 0,0 Tuple2D" => fn -> Tuple2D.set(board_tuple_2d, 0, 0, :boing) end,
    "set 0,0 Tuple1D" => fn -> Tuple1D.set(board_tuple_1d, 0, 0, :boing) end
  },
  pre_check: true,
  time: 0.5,
  warmup: 0.5,
  print: [benchmarking: false, configuration: false]
)

IO.puts("""

================= mixed bag ====================

""")

Benchee.run(
  %{
    "mixed bag List2D" => fn ->
      board =
        board_list_2d
        |> List2D.set(0, 0, :boing)
        |> List2D.set(4, 4, :boing)
        |> List2D.set(8, 8, :boing)

      val1 = List2D.get(board, 0, 0)
      val2 = List2D.get(board, 4, 4)
      val3 = List2D.get(board, 8, 8)

      {val1, val2, val3}
    end,
    "mixed bag List1D" => fn ->
      board =
        board_list_1d
        |> List1D.set(0, 0, :boing)
        |> List1D.set(4, 4, :boing)
        |> List1D.set(8, 8, :boing)

      val1 = List1D.get(board, 0, 0)
      val2 = List1D.get(board, 4, 4)
      val3 = List1D.get(board, 8, 8)

      {val1, val2, val3}
    end,
    "mixed bag MapTuple" => fn ->
      board =
        board_map_tuple
        |> MapTuple.set(0, 0, :boing)
        |> MapTuple.set(4, 4, :boing)
        |> MapTuple.set(8, 8, :boing)

      val1 = MapTuple.get(board, 0, 0)
      val2 = MapTuple.get(board, 4, 4)
      val3 = MapTuple.get(board, 8, 8)

      {val1, val2, val3}
    end,
    "mixed bag MapTupleFull" => fn ->
      board =
        board_map_tuple_full
        |> MapTupleFull.set(0, 0, :boing)
        |> MapTupleFull.set(4, 4, :boing)
        |> MapTupleFull.set(8, 8, :boing)

      val1 = MapTupleFull.get(board, 0, 0)
      val2 = MapTupleFull.get(board, 4, 4)
      val3 = MapTupleFull.get(board, 8, 8)

      {val1, val2, val3}
    end,
    "mixed bag Tuple2D" => fn ->
      board =
        board_tuple_2d
        |> Tuple2D.set(0, 0, :boing)
        |> Tuple2D.set(4, 4, :boing)
        |> Tuple2D.set(8, 8, :boing)

      val1 = Tuple2D.get(board, 0, 0)
      val2 = Tuple2D.get(board, 4, 4)
      val3 = Tuple2D.get(board, 8, 8)

      {val1, val2, val3}
    end,
    "mixed bag Tuple1D" => fn ->
      board =
        board_tuple_1d
        |> Tuple1D.set(0, 0, :boing)
        |> Tuple1D.set(4, 4, :boing)
        |> Tuple1D.set(8, 8, :boing)

      val1 = Tuple1D.get(board, 0, 0)
      val2 = Tuple1D.get(board, 4, 4)
      val3 = Tuple1D.get(board, 8, 8)

      {val1, val2, val3}
    end
  },
  pre_check: true,
  time: 4,
  warmup: 1,
  print: [benchmarking: false, configuration: false]
)
