defmodule Board.MapTuple do
  @behaviour Board

  def new do
    %{}
  end

  def get(board, x, y), do: board[{x, y}]

  def set(board, x, y, value) do
    Map.put(board, {x, y}, value)
  end
end
