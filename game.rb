require_relative 'board.rb'
require_relative 'tile.rb'
require 'byebug'
require 'colorize'

class Game
  def initialize(filename)
    @board = Board.from_file(filename)
  end

  def run
    until game_over?
      render
      row, col, val = prompt
      @board.grid[row][col].value = val
    end
    render
    puts all_correct? ? "You are correct!" : "You made some mistakes!"
  end

  def all_correct?
    all_rows_correct? && all_columns_correct? && all_9_by_by_correct?
  end

  def all_rows_correct?
    correct_case = (1..9).to_a
    to_be_tested = @board.grid.map { |row| row.map { |tile| tile.value } }
    to_be_tested.all? { |row| row.sort == correct_case }
  end

  def all_columns_correct?
    correct_case = (1..9).to_a
    to_be_tested = @board.grid.map { |row| row.map { |tile| tile.value } }.transpose
    to_be_tested.all? { |row| row.sort == correct_case }
  end

  def all_9_by_by_correct?
    true
  end

  def prompt
    puts "Please input: row,col,val"
    input = nil
    until input.is_a?(Array) && input.all? { |int| int >= 0 && int < 10 }
      input = parse(gets.chomp)
    end
    input
  end

  def render
    lines = @board.grid.map do |line|
      new_line = []
      line.map { |tile| tile.to_s }.each_with_index do |line, idx|
        new_line << " " if idx % 3 == 0
        new_line << line
      end
      new_line.join
    end
    lines.each_with_index do |line, idx|
      puts "" if idx % 3 == 0
      puts line
    end
  end

  def parse(input)
    input.split(",").map(&:to_i)
  end

  def game_over?
    @board.grid.all? do |row|
      row.all? { |tile| tile.value != 0 }
    end
  end
end

if $PROGRAM_NAME == __FILE__
  filename = './puzzles/sudoku1-almost.txt'
  game = Game.new(filename)
  game.run
end
