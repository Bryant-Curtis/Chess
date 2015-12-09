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
