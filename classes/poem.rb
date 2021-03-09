
class Poem
  require 'uri'
  require 'net/http'
  require 'json'
  attr_reader :uri, :response_code, :informative_message, :raw_content, :poem_hash

  def initialize
    @uri = URI('https://poetrydb.org/random/1') # only pulls one random poem
    @response = Net::HTTP.get_response(uri)
    @response_code = @response.code

    @informative_message = validate_response_code(@response_code)
    @raw_content = @response.body
    parsed_content = JSON.parse(@raw_content)
    @poem_hash = parsed_content[0] # for some reason the parsed data comes in as an array

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
    abbrev_lines = 30
    poem_lines = @poem_hash['lines'] # should be coming in as array

    puts "#{@poem_hash["title"]} by #{@poem_hash["author"]}\n"
    22.times do print "-" end
    print "\n"

    if (line_number > abbrev_lines)
      while counter <= abbrev_lines do
        puts poem_lines[counter]
        counter += 1
      end
    else
      while counter <= line_number do
        puts poem_lines[counter]
        counter += 1
      end
      puts "\nHey! Sorry, but we truncated this poem because it was too long."
    end


  end





end
