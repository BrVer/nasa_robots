module NasaRobots
  class RobotDataParser
    def initialize(robot_data_input)
      @robot_data_input = robot_data_input
    end

    def parse
      @robot_data = {}
      raise ArgumentError, 'not enough data' unless @robot_data_input.count == 2

      parse_initial
      parse_commands
      @robot_data
    end

    private

    def parse_initial
      initial = @robot_data_input[0].strip.split(' ')

      unless DIRECTIONS.include? initial[2].to_sym
        raise ArgumentError, 'invalid initial direction'
      end

      @robot_data[:coords] = {
        x: initial[0].to_i,
        y: initial[1].to_i
      }
      @robot_data[:direction] = initial[2].to_sym
    end

    def parse_commands
      program = @robot_data_input[1].strip

      raise ArgumentError, 'invalid command' unless /^[MLR]+$/ =~ program

      @robot_data[:program] = program.split('').map(&:to_sym)
    end
  end
end
