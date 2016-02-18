require 'piece'
require 'steppingpieces'

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
