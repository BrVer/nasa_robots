module NasaRobots
  class Robot
    CIRCLE_DEGREES = 360
    QUARTER_DEGREES = 90

    attr_reader :position, :angle

    def initialize(position, orientation, program)
      @position = Position.new(position)
      set_angle(orientation)
      @initial_program = program # just in case we'll need it once
      @remaining_program = program
    end

    def next_command
      @remaining_program[0]
    end

    def finished?
      @remaining_program.empty?
    end

    def to_s
      "#{@position} #{orientation}"
    end

    def orientation
      DIRECTIONS[@angle / QUARTER_DEGREES]
    end

    def next_position
      if next_command == :M
        case @angle
        when 0
          Position.new(x: @position.x, y: @position.y + 1)
        when 90
          Position.new(x: @position.x + 1, y: @position.y)
        when 180
          Position.new(x: @position.x, y: @position.y - 1)
        when 270
          Position.new(x: @position.x - 1, y: @position.y)
        end
      else
        @position
      end
    end

    def turn_left
      @angle = (@angle - QUARTER_DEGREES) % CIRCLE_DEGREES
      make_another_command_performed
    end

    def turn_right
      @angle = (@angle + QUARTER_DEGREES) % CIRCLE_DEGREES
      make_another_command_performed
    end

    def move_to(position)
      @position = position
      make_another_command_performed
    end

    private

    def make_another_command_performed
      @remaining_program.slice!(0)
    end

    def set_angle(orientation)
      @angle = DIRECTIONS.index(orientation) * QUARTER_DEGREES
    end
  end
end
