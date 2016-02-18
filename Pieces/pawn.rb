require 'piece'

class Pawn < Piece
  SYMBOLS = { white: "\u2659", black: "\u265F" }

  def moves
    moves = []
    row, column = pos

    new_row = self.color == :white ? row + 1 : row - 1
    new_pos = [new_row, column]
    moves << new_pos if in_range?(new_pos) &&
    board[new_pos].is_a?(EmptyPiece)

    [[new_row, column + 1], [new_row, column - 1]].each do |delta|
      next if !in_range?(delta) || board[delta].is_a?(EmptyPiece)
      moves << delta unless board[delta].color == self.color
    end

    moves
  end

end
