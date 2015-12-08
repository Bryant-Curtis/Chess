require 'colorize'
require 'io/console'
require_relative 'Board'

class Display

  attr_reader :cursor, :selected, :board

  def initialize(board)
    @cursor = [0, 0]
    @selected = nil
    @board = board
  end

  def make_move
    until !!selected
      move_cursor
      render
    end
    until !selected
      move = move_cursor
      render
    end
    move = make_move unless board.valid_move?(*move)

    board.move(*move)
  end

private

  def move_cursor
    move = read_char
    parse_input(move)
  end

  def render
    puts "\e[H\e[2J"
    rendered = board.grid.map.with_index do |rank, idx1|
      rank.map.with_index do |tile, idx2|
        tile = tile.is_a?(Piece) ? '*' : '_'

        if [idx1, idx2] == cursor
          tile = tile.colorize(:blue)
        end

        if [idx1, idx2] == selected
          tile = tile.colorize(:red)
        end

        tile
      end.join("")
    end
    puts rendered
  end

  def parse_input(input)
    case input
    when "\e[A"
      @cursor[0] = @cursor[0] - 1 < 0 ? @cursor[0] : @cursor[0] - 1
    when "\e[B"
      @cursor[0] = @cursor[0] + 1 > 7 ? @cursor[0] : @cursor[0] + 1
    when "\e[C"
      @cursor[1] = @cursor[1] + 1 > 7 ? @cursor[1] : @cursor[1] + 1
    when "\e[D"
      @cursor[1] = @cursor[1] - 1 < 0 ? @cursor[1] : @cursor[1] - 1
    when "\r"
      if @selected.nil?
        @selected = @cursor.dup
      else
        move = [@selected.dup, @cursor.dup]
        @selected = nil
        move
      end
    end
  end

  def read_char
    STDIN.echo = false
    STDIN.raw!

    input = STDIN.getc.chr
    if input == "\e" then
      input << STDIN.read_nonblock(3) rescue nil
      input << STDIN.read_nonblock(2) rescue nil
    end
  ensure
    STDIN.echo = true
    STDIN.cooked!

    return input
  end

end
