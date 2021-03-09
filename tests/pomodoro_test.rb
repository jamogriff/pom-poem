require 'minitest/autorun'
require 'minitest/pride'
require_relative '../classes/pomodoro.rb'
require_relative '../classes/modules.rb'

class PomodoroTest < MiniTest::Test
  include Math
  include Validation
  attr_accessor :pom

  def setup
    @pom = Pomodoro.new('en')
  end

  # parallelize_me!()

  def test_time_offset

    # acceptable_error_rate = 0.001 # error rate of 0.1%
    ideal_runtime = convert_to_seconds(@pom.timer_length)
    actual_runtime = @pom.program_length
    time_delta = (actual_runtime - ideal_runtime).abs # how many seconds difference the results are
    baseline_error_rate = sig_figs(approx_percent(time_delta, ideal_runtime))
    actual_error_rate = sig_figs(approx_percent(time_delta, actual_runtime))

    puts "Time difference: #{time_delta} seconds."
    puts "Control error rate: #{baseline_error_rate}%"
    puts "Actual error rate: #{actual_error_rate}%"

    # 0.01% off of the actual time is absolutely acceptable for the purposes of a Pom timer
    assert_in_delta baseline_error_rate, actual_error_rate, 0.01
  end

  # Bug due to while loop encounters case where percentage can hit 101%
  def test_ending_percentage
    assert_equal 100, @pom.end_percentage
  end


  # This is a *very* stringent test to ensure that run_time and counter variables increment
  # at the same rate and ensures there is 0% difference at all times during runtime.
  # However, updating run_time with Time.now more than every 10 seconds is overkill for this application.
  # def test_runtime_is_synced
  #
  #   new_pom = Pomodoro.new('es')
  #
  #   control_runtime_log = create_control_hash(new_pom.run_time_log, convert_to_seconds(new_pom.timer_length))
  #
  #   puts control_runtime_log
  #   puts new_pom.run_time_log
  #
  #   assert_equal control_runtime_log, new_pom.run_time_log
  #
  # end


end
