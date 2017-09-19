require_relative '../test_helper'

class RobotDataParserTest < Minitest::Test
  def test_it_works_correctly
    test_input = ['1 2 N', 'LMLMLMLMM']
    expected_output = {
      coords: { x: 1, y: 2 },
      direction: :N,
      program: %i[L M L M L M L M M]
    }
    assert_equal expected_output,
                 NasaRobots::RobotDataParser.new(test_input).parse
  end

  def test_it_expect_2_lines
    test_input = ['1 2 N']
    e = assert_raises { NasaRobots::RobotDataParser.new(test_input).parse }
    assert_instance_of ArgumentError, e
  end

  def test_it_check_direction
    test_input = ['1 2 A', 'LMLMLMLMM']
    e = assert_raises { NasaRobots::RobotDataParser.new(test_input).parse }
    assert_instance_of ArgumentError, e
    assert_equal 'invalid initial direction', e.message
  end

  def test_it_check_commands
    test_input = ['1 2 N', 'LMLZZZZZZMM']
    e = assert_raises { NasaRobots::RobotDataParser.new(test_input).parse }
    assert_instance_of ArgumentError, e
    assert_equal 'invalid command', e.message
  end
end
