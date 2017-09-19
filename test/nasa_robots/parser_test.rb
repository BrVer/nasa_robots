require_relative '../test_helper'

class ParserTest < Minitest::Test
  def test_it_works_correctly
    test_input = <<-INPUT
      5 5
      1 2 N
      LMLMLMLMM
      3 3 E
      MMRMMRMRRM
    INPUT
    expected_output = {
      field_dimensions: { x: 5, y: 5 },
      robots: [
        {
          coords: { x: 1, y: 2 },
          direction: :N,
          program: %i[L M L M L M L M M]
        },
        {
          coords: { x: 3, y: 3 },
          direction: :E,
          program: %i[M M R M M R M R R M]
        }]
    }
    assert_equal expected_output,
                 NasaRobots::Parser.new(test_input).parse
  end

  def test_it_expect_a_string
    e = assert_raises { NasaRobots::Parser.new(3).parse }
    assert_instance_of TypeError, e
  end

  def test_it_expect_at_least_3_lines
    test_input = <<-INPUT
      5 5
      1 2 N
    INPUT
    e = assert_raises { NasaRobots::Parser.new(test_input).parse }
    assert_instance_of ArgumentError, e
  end

  def test_it_check_field_dimensions
    test_input = <<-INPUT
      0 1
      1 2 N
      LMLMLMLMM
    INPUT
    e = assert_raises { NasaRobots::Parser.new(test_input).parse }
    assert_instance_of ArgumentError, e
  end

  def test_it_check_robots_data
    test_input = <<-INPUT
      5 5
      1 2 A
      LMLMLMLMM
    INPUT
    e = assert_raises { NasaRobots::Parser.new(test_input).parse }
    assert_instance_of ArgumentError, e
    assert_equal 'error parsing data for robot 1 : invalid initial direction',
                 e.message
  end
end
