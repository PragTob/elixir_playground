defmodule Magic do
  @board_modules [
    Board.List1D,
    Board.List2D,
    Board.MapTuple,
    Board.MapTupleFull,
    Board.Tuple1D,
    Board.Tuple2D
  ]
  defmacro get(x, y) do
    jobs =
      Enum.map(@board_modules, fn module ->
        board = module.new

        quote do
          {unquote(module),
           fn ->
             unquote(module).get(
               unquote(Macro.escape(board)),
               unquote(x),
               unquote(y)
             )
           end}
        end
      end)

    jobs
  end
end

defmodule BoardBenchmark do
  require Magic
  import Magic

  def go do
    headline("get(0, 0)")

    Benchee.run(get(0, 0),
      time: 0.5,
      warmup: 0.2,
      print: [benchmarking: false, configuration: false]
    )
  end

  def headline(text) do
    IO.puts("""

    ================= #{text} ====================

    """)
  end
end

BoardBenchmark.go()
