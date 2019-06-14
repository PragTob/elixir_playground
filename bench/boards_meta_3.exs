defmodule Magic do
  @board_modules [
    Board.List1D,
    Board.List2D,
    Board.MapTuple,
    Board.MapTupleHalfFull,
    Board.MapTupleFull,
    Board.Tuple1D,
    Board.Tuple2D
  ]

  defmacro get(x, y) do
    Enum.map(@board_modules, fn module ->
      quote do
        {unquote(module),
         {fn board ->
            unquote(module).get(
              board,
              unquote(x),
              unquote(y)
            )
          end, before_scenario: fn _ -> unquote(module).new end}}
      end
    end)
  end

  defmacro set(x, y, value) do
    Enum.map(@board_modules, fn module ->
      quote do
        {unquote(module),
         {fn board ->
            unquote(module).set(
              board,
              unquote(x),
              unquote(y),
              unquote(value)
            )
          end, before_scenario: fn _ -> unquote(module).new end}}
      end
    end)
  end

  defmacro board_creation() do
    Enum.map(@board_modules, fn module ->
      quote do
        {unquote(module), fn -> unquote(module).new() end}
      end
    end)
  end

  defmacro mixed_bag() do
    Enum.map(@board_modules, fn module ->
      quote do
        {unquote(module),
         {fn board ->
            new_board =
              board
              |> unquote(module).set(0, 0, :boing)
              |> unquote(module).set(4, 4, :boing)
              |> unquote(module).set(8, 8, :boing)

            val1 = unquote(module).get(board, 0, 0)
            val2 = unquote(module).get(board, 4, 4)
            val3 = unquote(module).get(board, 8, 8)

            # assign and return so no fancy potential compiler optimization could go "woops you don't need those"
            {val1, val2, val3}
          end, before_scenario: fn _ -> unquote(module).new end}}
      end
    end)
  end
end

defmodule BoardBenchmark do
  require Magic
  import Magic

  # can't use macros top level if defined in the same context and I want to use them in the same context
  def go do
    Enum.each([{0, 0}, {4, 4}, {8, 8}], fn {x, y} ->
      headline("get(#{x}, #{y})")

      Benchee.run(get(x, y),
        time: 0.5,
        warmup: 0.1,
        print: [benchmarking: false, configuration: false]
      )
    end)

    Enum.each([{0, 0}, {4, 4}, {8, 8}], fn {x, y} ->
      headline("set(#{x}, #{y}, :boom)")

      Benchee.run(set(x, y, :boom),
        time: 0.5,
        warmup: 0.1,
        print: [benchmarking: false, configuration: false]
      )
    end)

    headline("mixed bag (3 sets, 3 gets)")

    Benchee.run(mixed_bag(),
      time: 0.5,
      warmup: 0.1,
      memory_time: 0.1,
      print: [benchmarking: false, configuration: false],
      formatters: [{Benchee.Formatters.Console, extended_statistics: true}]
    )

    headline("Board creation")

    Benchee.run(board_creation(),
      time: 0.5,
      warmup: 0.1,
      memory_time: 0.1,
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
