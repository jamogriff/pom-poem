# classes used in this program
module Validation

  def format_date(string)

    # this validation should be replaced
    # FEATURE NEEDED
    if(string.is_a? String)
      string.split("/")
      return string
    else
      puts "Error!"
      return false
    end
  end
end


class User
  #include Validation
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
    require 'fileutils' # used to interact with file directory

    puts "  ___  ___  __  __   ___  ___  ___ __  __ "
    puts ' | _ \/ _ \|  \/  | | _ \/ _ \| __|  \/  |'
    puts ' |  _/ (_) | |\/| | |  _/ (_) | _|| |\/| |'
    puts ' |_|  \___/|_|  |_| |_|  \___/|___|_|  |_|'
    puts "  ~ Created by Jamison Griffith - 2021 ~  "
    print "\n"
    puts  "Checking for program configuration..."

    if(!File.exist?('config.txt'))
      puts "No record of current user exists!"
      puts "No existe registro de persona!"

      File.new("config.txt", "w")
      File.open("config.txt")

      # used to keep asking user questions if they don't enter info correctly
      lang_check = false
      name_check = false
      day_check = false

      while lang_check == false do
        puts "Please type 'en' for English prompts or 'es' for Spanish."
        puts "Por favor escribe 'en' para texto en ingles o 'es' en espanol."
        print "> "

        @language = gets.chomp

        if(self.language == "en" || self.language == "es")
          File.write("config.txt", "language: #{language}", mode: "w")
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
            File.write("config.txt", "name: #{self.name}", mode: "a")
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
            File.write("config.txt", "name: #{self.name}", mode: "a")
            puts "Nice to meet you, #{self.name}."
            name_check = true
          end
        end
      end


      while day_check == false do
        if(self.language == "es")
          puts "Por favor escribe su cumpleanos para continuar. Formato de ejemplo: 09/17/90"
          puts "Estos datos solo se utilizan para una notificacion de feliz cumpleanos 🥳"
          print "> "
          @birthday = gets.chomp

          # =begin
          # This validation function is going to need some work...
          # Found in Validation module
          # if(format_date(self.birthday))
          #   day_check == true
          # end
          # =end

        else
          puts "Please enter your birthday to continue. Example formatting: 09/17/90"
          puts "This data is only used to wish you a happy birthday 🥳"
          print "> "
          @birthday = gets.chomp
        end

        File.write("config.txt", "birthday: #{self.birthday}", mode: "a")
        day_check = true
      end

      # All config checks complete, now we welcome the user
      welcome_user

    else # aka config.txt exists
      # scan doc for required parts, etc
      # FUNCTION NEEDED
      puts "We found a config file! ⚡️"
      welcome_user

    end

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
