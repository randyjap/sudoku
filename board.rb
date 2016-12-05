class Board
  attr_reader :grid

  def self.from_file(filename)
    rows = File.readlines(filename).map(&:chomp)
    grid = rows.map { |row| row.chars.map {|chr| Tile.new(chr.to_i)} }
    self.new(grid)
  end

  def initialize(grid)
    @grid = grid
  end
end
