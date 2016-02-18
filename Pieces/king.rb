require 'piece'
require 'steppingpieces'

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
