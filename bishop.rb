require 'piece'
require 'slidingpieces'

class Bishop < SlidingPiece
  SYMBOLS = { white: "\u2657", black: "\u265D" }

  def move_dirs
    DIAG_DELTAS
  end

end
