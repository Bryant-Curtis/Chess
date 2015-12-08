class Piece

  attr_accessor :pos
  attr_reader :color, :board

  def initialize(pos, color, board)
    @pos = pos
    @color = color
    @board = board
  end

  def moves
    self.moves
  end

  def to_s
    self.class::SYMBOLS[self.color]
  end

  def in_range?(position)
    position.none? { |x| x > 7 || x < 0 }
  end

  def move_into_check?(pos)
    
  end
end

class EmptyPiece < Piece
  SYMBOLS = Hash.new { "_" }
  def moves
    []
  end
end

class SlidingPiece < Piece
  DIAG_DELTAS = [
    [1, 1],
    [1, -1],
    [-1, -1],
    [-1, 1]
  ]

  STRAIGHT_DELTAS = [
    [1, 0],
    [0, 1],
    [0, -1],
    [-1, 0]
  ]

  def moves
    moves = []

    self.move_dirs.each do |delta|
      current_x, current_y = pos
      new_pos = [delta[0] + current_x, delta[1] + current_y]
      # next unless in_range?(new_pos)

      while in_range?(new_pos) && board[new_pos].is_a?(EmptyPiece)
        # break if new_pos.any? { |x| x > 7 || x < 0 }
         moves << new_pos
         current_x, current_y = new_pos
         new_pos = [delta[0] + current_x, delta[1] + current_y]
      end

      if in_range?(new_pos)
        moves << new_pos unless board[new_pos].color == self.color
      end
    end

   moves
  end




end

class Bishop < SlidingPiece
  SYMBOLS = { white: "\u2657", black: "\u265D" }

  def move_dirs
    DIAG_DELTAS
  end

  end

class Rook < SlidingPiece
  SYMBOLS = { white: "\u2656", black: "\u265C" }

    def move_dirs
      STRAIGHT_DELTAS
    end

end

class Queen < SlidingPiece
  SYMBOLS = { white: "\u2655", black: "\u265B" }


  def move_dirs
    STRAIGHT_DELTAS + DIAG_DELTAS
  end

end




class SteppingPiece < Piece

  def moves
    moves = []
    self.move_dirs.each do |delta|
      current_x, current_y = pos
      new_pos = [delta[0] + current_x, delta[1] + current_y]
      next unless in_range?(new_pos)

      moves << new_pos unless board[new_pos].color == self.color
    end

    moves
  end
end

class Knight < SteppingPiece
  SYMBOLS = { white: "\u2658", black: "\u265E" }

  KNIGHT_DELTAS = [
   [1, 2],
   [1, -2],
   [2, 1],
   [2, -1],
   [-1, 2],
   [-1, -2],
   [-2, 1],
   [-2, -1]
  ]

  def move_dirs
    KNIGHT_DELTAS
  end
end

class King < SteppingPiece
  SYMBOLS = { white: "\u2654", black: "\u265A" }

  KING_DELTAS = [
    [1, 0],
    [1, -1],
    [0, 1],
    [0, -1],
    [-1, 1],
    [-1, 0],
    [1, 1],
    [-1, -1]
  ]

  def move_dirs
    KING_DELTAS
  end
end

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
