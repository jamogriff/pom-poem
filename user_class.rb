# classes used in this program

class User
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

    if(!File.exist?('config.txt'))
      puts "No record of current user exists!"
      puts "No existe registro de persona!"

      File.new("config.txt", "w")
      File.open("config.txt")

      puts "Please type 'en' for English prompts or 'es' for Spanish."
      puts "Por favor escribe 'en' para texto en ingles o 'es' en espanol."
      print "> "

      @language = gets.chomp
      File.write("config.txt", "language: #{language}", mode: "w")

      puts "Please input your first name to continue."
      print "> "

      @name = gets.chomp

      puts "Nice to meet you, #{self.name}."
      puts "Please enter your birthday to continue. Example formatting: 09/17/90"
      puts "This data is only used to wish you a happy birthday 🥳"
      print "> "

      @birthday = gets.chomp
      welcome_user
      
    else # aka config.txt exists
      # scan doc for required parts, etc FUNCTION NEEDED
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
