require 'piece'
class SlidingPiece < Piece

  DIAG_DELTAS = [
    [1, 1],
    [1, -1],
    [-1, -1],
    [-1, 1]
  ]

  STRAIGHT_DELTAS = [
    [1, 0],
    [0, 1],
    [0, -1],
    [-1, 0]
  ]

  def moves
    moves = []

    self.move_dirs.each do |delta|
      current_x, current_y = pos
      new_pos = [delta[0] + current_x, delta[1] + current_y]
      # next unless in_range?(new_pos)

      while in_range?(new_pos) && board[new_pos].is_a?(EmptyPiece)
        # break if new_pos.any? { |x| x > 7 || x < 0 }
         moves << new_pos
         current_x, current_y = new_pos
         new_pos = [delta[0] + current_x, delta[1] + current_y]
      end

      if in_range?(new_pos)
        moves << new_pos unless board[new_pos].color == self.color
      end
    end

   moves
  end

end
