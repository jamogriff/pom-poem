require 'minitest/autorun'
require_relative '../classes/pomodoro.rb'
require_relative '../classes/modules.rb'

class PomodoroTest < MiniTest::Test
  include Math

  def test_time_offset
    pom = Pomodoro.new('en')

    start_time = pom.start.to_i
    pom_time = convert_to_seconds(pom.minutes)
    end_time = pom.future.to_i
    acceptable_error_rate = pom_time * 0.01

    # NEEDS FIXED
    # this strategy of measuring actual run-time is flawed for some reason...
    # keep getting 0.01 for some reason....
    assert_in_delta acceptable_error_rate, (pom.run_time * 0.01), 0.5
  end

  # def test_ending_percentage
  #   pom = Pomodoro.new('en')
  #   assert_equal pom.minutes, pom.counter
  # end
end
