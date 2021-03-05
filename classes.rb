# classes and modules used in this program

 #  __  __         _      _
 # |  \/  |___  __| |_  _| |___ ___
 # | |\/| / _ \/ _` | || | / -_|_-<
 # |_|  |_\___/\__,_|\_,_|_\___/__/
 #


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



# straightforward percentage function
module Math
  def percent_of(num, div)
    num.to_f / div.to_f * 100.0
  end

  def convert_to_seconds(minutes)
    seconds = minutes * 60
    return seconds
  end

  def convert_divpersec(minutes)
    seconds = convert_to_seconds(minutes)
    div_per_sec = seconds / 40
    return div_per_sec
  end
end


 #   ___ _
 #  / __| |__ _ ______ ___ ___
 # | (__| / _` (_-<_-</ -_|_-<
 #  \___|_\__,_/__/__/\___/__/
 #

class User
  include Validation
  attr_accessor :name, :language


  def initialize

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
    print("\n")

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
        Pomodoro.new(@language)
      end
    end
  end


  def get_language
    return self.language
  end

end



class Pomodoro
  attr_accessor :timer, :now, :future, :language
  include Math

  def initialize(language)
    @language = language

    if (self.language == 'es')
      puts "Entras cuantos minutos quieres para tu Pomodoro: "
    else
      puts "Enter how many minutes you want to set your Pomodoro for: "
    end
    print "> "

    @minutes = gets.chomp.to_i
    @now = Time.now
    @future = self.now + convert_to_seconds(@minutes)

    start_timer

  end

  def start_timer
    if (self.language == 'es')
      puts self.now.strftime("Tu Pom de #{@minutes} minutos comienza en %l:%M.")
    else
      puts self.now.strftime("Your #{@minutes} minute timer starts at %l:%M.")
    end

    counter = 0
    # I'm refering to facsimilies of time (counter and timerCount)
    # because I don't know how to properly divide or find percentage of time objects
    # Likely could do more manipulations if convert Time objects .to_i

    # Also, if an odd number is chosen, ending percentage is 101%...
    # likely due to rounding.
    printf("Progress: [%-60s] 0%%","")
    while self.now <= self.future do
      self.now += 1
      counter += 1

      # basically this progress bar will add another bar (up to 60) every division of "timer"
      # print formatting performs a carriage return each time its written to create the illusion of movement
      # percentage complete is also listed at the end
      if counter % @minutes == 0 then printf("\rProgress: [%-60s] %d%%", "=" * (counter/@minutes), percent_of(counter, convert_to_seconds(@minutes)))
      end
      # I'm using this sleep function to essentially keep track of time passing, it's not terribly accurate
      # although for the purposes of a Pomodoro timer it works fine (roughly 0.6% error)
      sleep(1)
    end

    if (self.language == 'es')
      puts "\nEl tiempo ha terminado!\a"
    else
      puts "\nTime is up!\a" # added \a for an audible beep
      puts "Program performed #{counter} operations and was #{Time.now - @future} seconds off the exact ending time."
    end

  end

end
