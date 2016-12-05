class Tile
  attr_accessor :value

  def initialize(value = 0)
    @value = value
    @given = (value == 0 ? false : true)
  end

  def color
    given? ? :red : :yellow
  end

  def given?
    @given
  end

  def to_s
    @value == 0 ? "0" : @value.to_s.colorize(color)
  end

  def value=(new_value)
    if given?
      puts "Can't change this"
    else
      @value = new_value
    end
  end
end
