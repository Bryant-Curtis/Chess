require 'piece'
require 'slidingpieces'

class Rook < SlidingPiece
  SYMBOLS = { white: "\u2656", black: "\u265C" }

    def move_dirs
      STRAIGHT_DELTAS
    end

end
