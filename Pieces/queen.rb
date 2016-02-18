require 'piece'
require 'slidingpieces'

class Queen < SlidingPiece
  SYMBOLS = { white: "\u2655", black: "\u265B" }


  def move_dirs
    STRAIGHT_DELTAS + DIAG_DELTAS
  end

end
