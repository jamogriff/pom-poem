# classes and modules used in this program

module Validation

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
      puts "Invalid config file found! Deleting #{config}..."
      puts "Archivo de configuración dañado! Borrar #{config}..."
      File.delete(config)
    else
      return lang, name
    end

  end
end


class User
  include Validation
  attr_accessor :name, :language

  def initialize

    puts "  ___  ___  __  __   ___  ___  ___ __  __ "
    puts ' | _ \/ _ \|  \/  | | _ \/ _ \| __|  \/  |'
    puts ' |  _/ (_) | |\/| | |  _/ (_) | _|| |\/| |'
    puts ' |_|  \___/|_|  |_| |_|  \___/|___|_|  |_|'
    puts "  ~ Created by Jamison Griffith - 2021 ~  "
    print "\n"


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

    # puts "We found a valid config file! ⚡️"
    # puts "We have your data: #{config_data}."

    @language = config_data[0]
    @name = config_data[1]

  end


  # Setting instance variables here is really only to streamline whether the user
  # sees prompts in Spanish or English upon first using the program.
  # After this method is finished, instance variables originate from config.txt
  # and are reassigned.
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
          name_check = true
        end
      end
    end
  end

  def welcome_user
    time = Time.now

    if self.language == "es"
      puts "Bienvenidos a Pom Poem, #{self.name}."
      puts time.strftime("Hoy es %l:%M %p on %A, %B %-d, %Y")
    else
      puts "Welcome to Pom Poem, #{self.name}."
      puts time.strftime("Today is %l:%M %p on %A, %B %-d, %Y")
    end

  end

  def choose_option
    option_check = false

    while option_check == false do
      if self.language == "es"
        puts "Entras 1 o 2 para continuar:"
        puts "1. Otro Pom"
        puts "2. Cerrar la aplicación"
        print "> "
        user_option = gets.chomp

        if (user_option == "2")
          puts "Adios, #{self.name}!"
          exit
        end
      else
        puts "Enter 1 or 2 to continue:"
        puts "1. Another Pom"
        puts "2. Close the application"
        print "> "
        user_option = gets.chomp

        if (user_option == "2")
          puts "Goodbye, #{self.name}!"
          exit
        end
      end

      if (user_option == "1")
        option_check = true
        puts "Okay, we'll work on that feature soon..."
      end
    end
  end

  def get_language
    return self.language
  end

end


class Pomodoro
  attr_accessor :timer, :now, :future

  def initialize
    # Need to research how to access User class variables
  end

end


# straightforward percentage function
class Numeric
  def percent_of(n)
    self.to_f / n.to_f * 100.0
  end
end
