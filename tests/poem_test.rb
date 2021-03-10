require 'minitest/autorun'
require 'minitest/pride'
require_relative '../classes/poem.rb'

class PoemTest < MiniTest::Test
attr_accessor :poem

  #parallelize_me!()

  def setup
    cyan = "cyan"
    @poem = Poem.new(cyan)
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

  def test_cyan_branch_mapping_to_number
    short_poem = Poem.new("cyan")
    assert_includes [2, 3, 4, 5, 6, 7], short_poem.line_count
  end

  def test_magenta_branch_mapping_to_number
    short_poem = Poem.new("magenta")
    assert_includes [8, 9, 10, 11, 12, 13], short_poem.line_count
  end

  def test_yellow_branch_mapping_to_number
    short_poem = Poem.new("yellow")
    assert_includes [14, 15, 16, 17, 18, 19], short_poem.line_count
  end

  def test_black_branch_mapping_to_number
    short_poem = Poem.new("black")
    assert_includes [20, 21, 22, 23, 24, 25], short_poem.line_count
  end



end
