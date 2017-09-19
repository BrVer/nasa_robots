require_relative '../test_helper'

class MissionTest < Minitest::Test
  def test_it_works_correctly
    test_input = <<-INPUT
      5 5
      1 2 N
      LMLMLMLMM
      3 3 E
      MMRMMRMRRM
    INPUT
    expected_output = ['1 3 N', '5 1 E']
    assert_equal expected_output, NasaRobots::Mission.new(test_input).perform
  end

  def test_it_does_not_allow_to_put_outside_the_field
    test_input = <<-INPUT
      5 5
      1 15 N
      LLLL
    INPUT
    e = assert_raises { NasaRobots::Mission.new(test_input).perform }
    assert_instance_of ArgumentError, e
    assert_equal 'robot 1: initial position is outside the field', e.message
  end

  def test_it_does_not_allow_to_put_to_occupied_position
    test_input = <<-INPUT
      5 5
      1 2 N
      LLLL
      1 2 N
      RRRR
    INPUT
    e = assert_raises { NasaRobots::Mission.new(test_input).perform }
    assert_instance_of ArgumentError, e
    assert_equal 'robot 2: initial position is already occupied by another robot',
                 e.message
  end

  def test_it_does_not_allow_to_move_outside_the_field
    test_input = <<-INPUT
      5 5
      1 2 N
      MMMMMMMMMMMM
    INPUT
    e = assert_raises { NasaRobots::Mission.new(test_input).perform }
    assert_instance_of RuntimeError, e
    assert_equal 'robot 1: command leads outside the field', e.message
  end

  def test_it_does_not_allow_to_move_to_occupied_position
    test_input = <<-INPUT
      5 5
      1 2 N
      LLLL
      1 1 N
      MMM
    INPUT
    e = assert_raises { NasaRobots::Mission.new(test_input).perform }
    assert_instance_of RuntimeError, e
    assert_equal 'robot 2: command leads to occupied position', e.message
  end
end
