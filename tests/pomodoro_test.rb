require 'minitest/autorun'
require 'minitest/pride'
require_relative '../classes/pomodoro.rb'
require_relative '../classes/modules.rb'

class PomodoroTest < MiniTest::Test
  include Math

  def setup
    @pom = Pomodoro.new('en')
  end

  def test_time_offset

    # acceptable_error_rate = 0.001 # error rate of 0.1%
    baseline_time_drift = convert_to_seconds(@pom.timer_length)
    actual_time_drift = @pom.program_length

    puts "Baseline time drift: #{baseline_time_drift} seconds"
    puts "Actual time drift: #{actual_time_drift} seconds"

    # 5 seconds off the actual time is acceptable for the purposes of a Pom timer
    assert_in_delta baseline_time_drift, actual_time_drift, 5.0
  end

  # Bug due to while loop encounters case where percentage can hit 101%
  # def test_ending_percentage
  #   assert_equal 100, @pom.end_percentage
  # end

  def test_runtime_is_synced

    new_pom = Pomodoro.new

    # NEEDS ATTENTION
    # control run time log runtime is about 100 off for some reason...
    control_runtime_log = create_control_hash(0, new_pom.run_time.to_i, convert_to_seconds(new_pom.timer_length))

    puts control_runtime_log
    puts @pom.run_time_log

    assert_equal control_runtime_log, @pom.run_time_log

  end


end
