require_relative 'Piece'
require_relative 'Display'

class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
    setup
  end


  def [](pos)
    rank, file = pos
    @grid[rank][file]
  end

  def []=(pos, value)
    rank, file = pos
    @grid[rank][file] = value
  end

  def setup
    @grid.map.with_index do |_, irow|
      if irow < 2 || irow > 5
        @grid[irow].map!.with_index { |_, idx| Piece.new([irow, idx]) }
        @grid[-(irow + 1)].map!.with_index { |_, idx| Piece.new([@grid.size-irow-1, idx]) }
      else
        @grid[irow].map!.with_index { |_, idx| EmptyPiece.new([irow, idx]) }
      end
    end
  end

  def move(start_pos, end_pos)
    return false unless self[start_pos].moves.include?(end_pos)
    self[start_pos].pos = end_pos

    if self[end_pos].color.nil?
      self[end_pos].pos = start_pos
      self[end_pos], self[start_pos] = self[start_pos], self[end_pos]
    else
      self[end_pos] = self[start_pos]
      self[start_pos] = EmptyPiece.new(start_pos)
    end
  end

  def valid_move?(start_pos, end_pos)
    return false if self[start_pos].is_a?(EmptyPiece)
    self[start_pos].moves.include?(end_pos)
  end

end
