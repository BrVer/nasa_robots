require_relative '../test_helper'

class RobotTest < Minitest::Test
  def test_it_sets_right_angle
    robot = NasaRobots::Robot.new(
      { x: 1, y: 2 },
      :W,
      %i[L M L M L M L M M]
    )
    assert_equal 270, robot.angle
  end

  def test_it_tells_if_finished
    robot = NasaRobots::Robot.new(
      { x: 1, y: 2 },
      :W,
      %i[L R]
    )
    assert_equal false, robot.finished?
    robot.turn_left
    assert_equal false, robot.finished?
    robot.turn_right
    assert_equal true, robot.finished?
  end

  def test_it_tells_next_command
    robot = NasaRobots::Robot.new(
      { x: 1, y: 2 },
      :W,
      %i[L R]
    )
    assert_equal :L, robot.next_command
  end

  def test_it_turns_left
    robot = NasaRobots::Robot.new(
      { x: 1, y: 2 },
      :W,
      %i[L R]
    )
    robot.turn_left
    assert_equal 180, robot.angle
  end

  def test_it_turns_right
    robot = NasaRobots::Robot.new(
      { x: 1, y: 2 },
      :W,
      %i[L R]
    )
    robot.turn_right
    assert_equal 0, robot.angle
  end

  def test_it_indicates_next_position_correctly
    robot = NasaRobots::Robot.new(
      { x: 1, y: 2 },
      :W,
      %i[L M L M]
    )
    assert_equal NasaRobots::Position.new(x: 1, y: 2), robot.next_position
    robot.turn_left
    assert_equal NasaRobots::Position.new(x: 1, y: 1), robot.next_position
    robot.move_to(robot.next_position)
    assert_equal NasaRobots::Position.new(x: 1, y: 1), robot.next_position
    robot.turn_left
    assert_equal NasaRobots::Position.new(x: 2, y: 1), robot.next_position
    robot.move_to(robot.next_position)
    assert_equal NasaRobots::Position.new(x: 2, y: 1), robot.next_position
  end

  def test_it_moves
    robot = NasaRobots::Robot.new(
      { x: 1, y: 2 },
      :E,
      [:M]
    )
    assert_equal NasaRobots::Position.new(x: 1, y: 2), robot.position
    robot.move_to(robot.next_position)
    assert_equal NasaRobots::Position.new(x: 2, y: 2), robot.position
  end
end
