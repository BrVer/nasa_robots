module NasaRobots
  class Field
    def initialize(dim_x, dim_y)
      @dim_x = dim_x
      @dim_y = dim_y
    end

    def in_field?(position)
      position.x.between?(0, @dim_x) && position.y.between?(0, @dim_y)
    end
  end
end
