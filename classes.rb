# classes used in this program
module Validation

  # THIS NEEDS TO BE REFACTORED
  # Setting the actual user variables should be done in User::initialize, and
  # should be set based on the actual array that is returned from the text file.
  def write_config(config)
    require 'fileutils' # used to interact with file directory

    puts "Thanks for using Pom Poem! Let's set up some quick user preferences."
    puts "Gracias por usar la Pom Poem! Primera haces tu configuración básica."

    File.new(config, "w")
    File.open(config)

    # used to keep asking user questions if they don't enter info correctly
    lang_check = false
    name_check = false

    while lang_check == false do
      puts "Please type 'en' for English prompts or 'es' for Spanish."
      puts "Por favor escribe 'en' para texto en ingles o 'es' en espanol."
      print "> "

      @language = gets.chomp

      if(self.language == "en" || self.language == "es")
        File.write(config, "language: #{language}", mode: "w")
        lang_check = true
      end
    end


    while name_check == false do
      if self.language == "es"
        puts "Gracias! Por favor escribe su nombre para continuar."
        print "> "
        @name = gets.chomp

        # the following check really isn't effective..
        # ADD FEATURE
        if(self.name.is_a? String)
          File.write(config, "\nname: #{self.name}", mode: "a")
          puts "Muchas gracias, #{self.name}."
          name_check = true
        end
      else
        puts "Thanks! Please input your first name to continue."
        print "> "
        @name = gets.chomp

        # the following check really isn't effective..
        # ADD FEATURE
        if(self.name.is_a? String)
          File.write(config, "\nname: #{self.name}", mode: "a")
          puts "Nice to meet you, #{self.name}."
          name_check = true
        end
      end
    end

  end


  # this function reads config.txt line by line and checks whether language and
  # name entries exist. Will only return data if both entries exist.
  def verify_config(config)
    lang = ""
    name = ""
    f = File.open(config, "r") # opens config file
    # Entries in config file should be in the following format:
    # Ex: 'language: en\n'

    f.each_line do |line|
      # these variables return the first index of specified string
      lang_index = line =~ /language/ # regex search for language
      name_index = line =~ /name/ # regex search for name

      # if there's a match, then resulting data entry is captured
      if (lang_index != nil)
        lang = line[lang_index + 10..-2] # why + 10? Because 'language: ' is 10 chars
        # why -2? Because there's a newline char at end.
      elsif (name_index != nil)
        name = line[name_index + 6..-1]
      end

    end
    f.close

    # if either lang or name weren't found, the config file is invalid and is deleted
    # if both entries were found then returns their associated values
    if lang.empty? || name.empty?
      puts "Invalid config file found! Now deleting invalid file..."
      File.delete(config)
      puts "File deletion successful."
    else
      return lang, name
    end

  end
end



class User
  include Validation
  attr_accessor :name, :birthday, :language
=begin
  def initialize(n, b, l)
    @name = n
    @birthday = b
    @language = l
    time = Time.now

    if l == "es"
      puts "Bienvenidos a Poem de Pomodoro, #{self.name}."
      puts time.strftime("Hoy es %l:%M %p on %A, %B %-d, %Y")
    else
      puts "Welcome to Pomodoro Poem, #{self.name}."
      puts time.strftime("Today is %l:%M %p on %A, %B %-d, %Y")
    end
  end
=end

  def initialize

    puts "  ___  ___  __  __   ___  ___  ___ __  __ "
    puts ' | _ \/ _ \|  \/  | | _ \/ _ \| __|  \/  |'
    puts ' |  _/ (_) | |\/| | |  _/ (_) | _|| |\/| |'
    puts ' |_|  \___/|_|  |_| |_|  \___/|___|_|  |_|'
    puts "  ~ Created by Jamison Griffith - 2021 ~  "
    print "\n"
    puts  "Checking for program configuration..."


    config_file = "config.txt"

    if(!File.exist?(config_file))
      write_config(config_file)
      config_data = verify_config(config_file)
    elsif verify_config(config_file) == nil
      write_config(config_file)
      config_data = verify_config(config_file)
    else
      config_data = verify_config(config_file)
    end

    puts "We found a valid config file! ⚡️"
    puts "We have your data: #{config_data}."

    # Set user variables here!

  end

  def welcome_user
    time = Time.now

    if self.language == "es"
      puts "Bienvenidos a Poem de Pomodoro, #{self.name}."
      puts time.strftime("Hoy es %l:%M %p on %A, %B %-d, %Y")
    else
      puts "Welcome to Pomodoro Poem, #{self.name}."
      puts time.strftime("Today is %l:%M %p on %A, %B %-d, %Y")
    end

  end

end
