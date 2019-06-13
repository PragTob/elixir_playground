defmodule BoardTest do
  use ExUnit.Case, async: true

  @modules [
    Board.List2D,
    Board.List1D,
    Board.MapTuple,
    Board.Tuple2D,
    Board.Tuple1D,
    Board.MapTupleFull
  ]
  # for module <- @modules do
  Enum.each(@modules, fn module ->
    @module module
    describe "#{module}" do
      test "creating getting and setting" do
        board = @module.set(@module.new, 7, 4, :bingo)

        assert :bingo == @module.get(board, 7, 4)
      end

      test "the edges work" do
        board =
          @module.new
          |> @module.set(0, 0, 1)
          |> @module.set(0, 8, 2)
          |> @module.set(8, 0, 3)
          |> @module.set(8, 8, 4)

        assert @module.get(board, 0, 0) == 1
        assert @module.get(board, 0, 8) == 2
        assert @module.get(board, 8, 0) == 3
        assert @module.get(board, 8, 8) == 4
      end

      test "the center" do
        board = @module.set(@module.new, 4, 4, :foo)

        assert @module.get(board, 4, 4) == :foo
      end

      test "just stuff" do
        board =
          @module.new
          |> @module.set(2, 7, :white)
          |> @module.set(8, 2, :black)
          |> @module.set(5, 6, :none)
          |> @module.set(2, 7, :woops)

        assert @module.get(board, 8, 2) == :black
        assert @module.get(board, 5, 6) == :none
        assert @module.get(board, 2, 7) == :woops
      end
    end
  end)
end
