module NasaRobots
  class Position
    attr_accessor :x, :y

    def initialize(x:, y:)
      @x = x
      @y = y
    end

    def ==(other)
      @x == other.x && @y == other.y
    end

    def to_s
      [@x, @y].join(' ')
    end
  end
end
