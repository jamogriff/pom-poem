require 'minitest/autorun'
require_relative '../classes/modules.rb'

def percent_of(status, max)
  (status.to_f / max.to_f) * 100
end

class ModulesTest < MiniTest::Test
  include Math
  
  def test_percentage
    result = percent_of(11*60+1, 11*60)
    assert_equal 100, result
  end

end
