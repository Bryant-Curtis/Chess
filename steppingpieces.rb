require 'piece'
class SteppingPiece < Piece

  def moves
    moves = []
    self.move_dirs.each do |delta|
      current_x, current_y = pos
      new_pos = [delta[0] + current_x, delta[1] + current_y]
      next unless in_range?(new_pos)

      moves << new_pos unless board[new_pos].color == self.color
    end

    moves
  end
end
