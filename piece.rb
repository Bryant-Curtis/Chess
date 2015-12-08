class Piece

  attr_accessor :pos
  attr_reader :color

  def initialize(pos, color=nil)
    @pos = pos
    @color = color
  end

  def moves
    self.moves
  end
end

class EmptyPiece < Piece

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

  attr_reader :board

  def initialize(pos, color, board)
    super(pos, color)
    @board = board
  end

  def moves
    moves = []
    self.move_dirs.each do |delta|
      current_x, current_y = pos
      new_pos = [delta[0] + current_x, delta[1] + current_y]
      while board[new_pos].is_a?(EmptyPiece)
        break if new_pos.any? { |x| x > 7 || x < 0 }
        moves << new_pos
        current_x, current_y = new_pos
        new_pos = [delta[0] + current_x, delta[1] + current_y]
      end
      unless board[new_pos].nil?
        moves << new_pos unless board[new_pos].color == self.color
      end
    end
    moves
  end



end

class Bishop < SlidingPiece

  def move_dirs
    DIAG_DELTAS
  end

  end

class Rook < SlidingPiece

    def move_dirs
      STRAIGHT_DELTAS
    end

end

class Queen < SlidingPiece

  def move_dirs
    STRAIGHT_DELTAS + DIAG_DELTAS
  end

end




class SteppingPiece < Piece
  attr_reader :board

  def initialize(pos, color, board)
    super(pos, color)
    @board = board
  end

  def moves
    moves = []
    self.move_dirs.each do |delta|
      current_x, current_y = pos
      new_pos = [delta[0] + current_x, delta[1] + current_y]
      next if board[new_pos].color == self.color
      next if new_pos.any? { |x| x > 7 || x < 0 }
      moves << new_pos
    end

    moves
  end
end

class Knight < SteppingPiece
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

  def initialize(pos, color, board)
    super(pos, color)
    @board = board
  end

  def moves
    moves = []
    row, column = pos
    new_pos = [row + 1, column]
    moves << new_pos if board[new_pos].is_a?(EmptyPiece)
    row, column = new_pos
    [1, -1].each do |diag|
      moves << [row, column + diag] unless board[row, column + diag].color == self.color
    end
  end


end
