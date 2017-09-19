module NasaRobots
  class Mission
    def initialize(input)
      @params = Parser.new(input).parse
    end

    def perform
      @field = Field.new(
        @params[:field_dimensions][:x],
        @params[:field_dimensions][:y]
      )
      @robots = []
      @params[:robots].each_with_index do |data, i|
        @robots << make_robot(data, i)
      end
      run_robots
      @robots.map(&:to_s)
    end

    private

    def make_robot(data, robot_index)
      pos = Position.new(data[:coords])
      unless @field.in_field?(pos)
        raise ArgumentError,
              robot_error(robot_index, 'initial position is outside the field')
      end
      unless position_is_free?(pos)
        raise ArgumentError,
              robot_error(robot_index, 'initial position is already occupied by another robot')
      end
      Robot.new(
        data[:coords],
        data[:direction],
        data[:program]
      )
    end

    def run_robots
      @robots.each_with_index { |robot, i| run_robot(robot, i) }
    end

    def run_robot(robot, robot_index)
      until robot.finished?
        case robot.next_command
        when :L
          robot.turn_left
        when :R
          robot.turn_right
        when :M
          next_pos = robot.next_position
          unless @field.in_field?(next_pos)
            fail robot_error(robot_index, 'command leads outside the field')
          end
          unless position_is_free?(next_pos)
            fail robot_error(robot_index, 'command leads to occupied position')
          end
          robot.move_to(next_pos)
        end
      end
    end

    def position_is_free?(position)
      !@robots.map(&:position).index(position)
    end

    def robot_error(robot_index, message)
      "robot #{robot_index + 1}: #{message}"
    end
  end
end
