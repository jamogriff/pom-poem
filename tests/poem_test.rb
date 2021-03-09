require 'minitest/autorun'
require 'minitest/pride'
require_relative '../classes/poem.rb'

class PoemTest < MiniTest::Test
attr_accessor :poem

  parallelize_me!()

  def setup
    @poem = Poem.new
  end

  def test_successful_api_connection
    ping = @poem.response_code

    if (ping == "200")
      assert_equal "Connection OK", @poem.informative_message
    end

  end

  def test_unsuccessful_api_connection
    ping =  @poem.response_code

    if (ping != "200")
      assert_equal "Oops! We lost connection to PoemDB, please try again later.", @poem.informative_message
    end

  end

  def test_content_is_not_empty
    assert @poem.raw_content != nil
  end

  def test_json_parse_successful
    assert_equal Hash, @poem.poem_hash.class
  end

  def test_linecount_is_number
    linecount = @poem.poem_hash['linecount'].to_i

    assert_equal Integer, linecount.class
  end



end
