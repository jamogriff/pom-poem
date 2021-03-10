
class Poem
  require 'uri'
  require 'net/http'
  require 'json'
  attr_reader :branch, :uri, :response_code, :informative_message, :line_count, :raw_content, :poem_hash

  def initialize(branch_color)
    @branch = branch_color
    @line_count = generate_linecount(@branch)
    url = 'https://poetrydb.org/linecount/' + @line_count.to_s
    @uri = URI(url) # only pulls one random poem

    @response = Net::HTTP.get_response(uri)
    @response_code = @response.code

    @informative_message = validate_response_code(@response_code)
    @raw_content = @response.body

    parsed_content = JSON.parse(@raw_content)
    num_poems_returned = parsed_content.count
    prng = Random.new
    @poem_hash = parsed_content[prng.rand(0..num_poems_returned)] # for some reason the parsed data comes in as an array


    if (@response_code == "200")
      @informative_message
      display_poem
    else
      @informative_messages
    end

  end

  def validate_response_code(code)
    successful_connection = "Connection OK"
    error_message = "Oops! We lost connection to PoemDB, please try again later."

    if (code != "200")
      return error_message
    else
      return successful_connection
    end

  end

  def display_poem

    counter = 0
    line_number = @poem_hash['linecount'].to_i
    poem_lines = @poem_hash['lines'] # should be coming in as array

    puts "#{@poem_hash["title"]} by #{@poem_hash["author"]}\n"
    22.times do print "-" end
    print "\n"

    while counter <= line_number do
      puts poem_lines[counter]
      counter += 1
    end


  end

  # This range of numbers
  def generate_linecount(branch)
    prng = Random.new
    # This hash allows the program to map what branch was set to a range of numbers.
    hash = {
      "cyan" => prng.rand(2..7),
      "magenta" => prng.rand(8..13),
      "yellow" => prng.rand(14..19),
      "black" => prng.rand(20..25)
    }

    linecount = hash[branch]

    return linecount

  end








end
