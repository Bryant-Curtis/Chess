require 'piece'

class EmptyPiece < Piece

  SYMBOLS = Hash.new { "_" }

  def moves
    []
  end
  
end
