module NasaRobots
  class Parser
    def initialize(params_string)
      unless params_string.is_a? String
        raise TypeError, 'params should be passed as a string'
      end
      @params_string = params_string
    end

    def parse
      @result = {}
      if @params_string.lines.count < 3
        raise ArgumentError,
              'you must specify field dimensions and at least one robot data'
      end
      extract_field_dimensions
      extract_robots_data
      @result
    end

    private

    def extract_field_dimensions
      dimensions = @params_string.lines[0].strip.split(' ').map(&:to_i)
      if dimensions.any? { |d| d < 1 }
        raise ArgumentError, 'field dimensions must be >= 1'
      end
      @result[:field_dimensions] = %i[x y].zip(
        dimensions
      ).to_h
    rescue StandardError
      raise ArgumentError, 'failed to parse field dimensions string'
    end

    def extract_robots_data
      @result[:robots] = []
      @params_string.lines[1..-1].each_slice(2).with_index do |robot_data, i|
        begin
          @result[:robots] << RobotDataParser.new(robot_data).parse
        rescue ArgumentError => e
          raise ArgumentError, "error parsing data for robot #{i + 1} : #{e}"
        end
      end
    end
  end
end
