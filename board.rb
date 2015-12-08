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

    @grid.map!.with_index do |row, irow|
      if irow == 0 || irow == 7
        color = :white if irow == 0
        color = :black if irow == 7

        row.map!.with_index do |tile, idx|
          if idx == 0 || idx == 7
            Rook.new([irow, idx], color, self)
          elsif idx == 1 || idx == 6
            Knight.new([irow, idx], color, self)
          elsif idx == 2 || idx == 5
            Bishop.new([irow, idx], color, self)
          elsif idx == 3
            Queen.new([irow, idx], color, self)
          elsif idx == 4
            King.new([irow, idx], color, self)
          end
        end

      elsif irow == 1
      row.map!.with_index { |_, idx| Pawn.new([irow, idx], :white, self) }

      elsif irow == 6
        row.map!.with_index { |_, idx| Pawn.new([irow, idx], :black, self) }

      else
        row.map!.with_index { |_, idx| EmptyPiece.new([irow, idx], nil, self) }
      end

    end
  end

  def move(start_pos, end_pos)

    return false unless self[start_pos].moves.include?(end_pos)
    self[start_pos].pos = end_pos

    if self[end_pos].is_a?(EmptyPiece)
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

  def in_check?(color)
    grid.any? do |row|
      row.any? do |tile|
        tile.color != color && tile.moves.include?(find_king(color))
      end
    end
  end

  def find_king(color)
    king_position = []

    self.grid.each_with_index do |row, irow|
      king_y = row.index { |tile| tile.is_a?(King) && tile.color == color }
      next if king_y.nil?
      king_position.concat([irow, king_y])
      break
    end

    king_position
  end

end
