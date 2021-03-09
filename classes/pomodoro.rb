# This class handles the time-tracking functionality of Pom-Poem

class Pomodoro
  attr_accessor :language, :timer_length, :start_time, :run_time, :program_length, :end_percentage
  attr_reader :run_time_log
  require_relative 'modules.rb'
  include Math

  # User language is only parameter that needs to be passed into a new Pomodoro class
  def initialize(language)
    @language = language

    # User prompt
    if (self.language == 'es')
      puts "Entras cuantos minutos quieres para tu Pomodoro: "
    else
      puts "Enter how many minutes you want to set your Pomodoro for: "
    end
    print "> "

    @timer_length = gets.chomp.to_i # I use 'to_i' method because it throws an error if user inputs a non-number
    @start_time = Time.now # keeping this var static is important to track time drift
    @run_time = @start_time # run_time is used as the variable that tracks time as the program runs
    @end_time = @start_time + convert_to_seconds(@timer_length) # ex: adding 120 seconds to start time for 2 min timer

    # The function below actual executes the timer. Details are in the method below.
    start_timer
  end


  # This method starts the timer and displays an ongoing progress bar during runtime.
  def start_timer
    if (@language == 'es')
      puts @start_time.strftime("Tu Pom de #{@timer_length} minutos comienza en %l:%M.")
    else
      puts @start_time.strftime("Your #{@timer_length} minute timer starts at %l:%M.")
    end

    # Initializing counter. Even though there are int properties of @run_time, a strict int counter
    # is extremely useful to make comparisons and enable progress bar and percentage.
    counter = 0
    # This hash is used to track whether run_time and counter stay synced throughout runtime.
    @run_time_log = {counter => @run_time.to_i}


    printf("Progress: [%-60s] 0%%","") # this prints a string with 60 open spaces in-between brackets

    # The strategy for time-keeping below is meant to be fairly efficient in terms
    # of lessening number of operation. The sleep method is used to keep track of time,
    # instead of a Time object. Operations should be fairly close to the amount of seconds
    # of timer_length as opposed to using Time.now in realtime to update tens of thousands of times.
    while @run_time <= @end_time do
      @run_time += 1 # increase runtime by 1 second
      counter += 1

      # ATTENTION: This is only used for testing counter and run_time syncing.
      # Please remove before using, otherwise it creates a large hash for no reason
      @run_time_log[counter] = @run_time.to_i


      # This progress bar will update progress bar and percentage complete (up to 60 times) every division of timer_length.
      # i.e. A 20 minute timer will update the progress bar every 20 seconds.
      # Print formatting performs a carriage return each time its written to create the illusion of movement
      if counter % @timer_length == 0 then printf("\rProgress: [%-60s] %d%%", "=" * (counter/@timer_length), approx_percent(counter, convert_to_seconds(@timer_length)))
      end

      # There is a slight time drift in the program (see below)
      # Updating run_time with actual time every 10 minutes allows time drift
      # to stay within 5 seconds of actual time.
      if counter % 600 == 0 then @run_time = Time.now
      end

      # This program's time drift occurs because of the sleep function used below.
      sleep(1) # sleep for 1 second
    end

    # These var's is used in testing to determine how accurate timer was
    @program_length = Time.now - @start_time
    @end_percentage = approx_percent(counter, convert_to_seconds(@timer_length))

    # Output to user
    if (self.language == 'es')
      puts "\nEl tiempo ha terminado!\a"
    else
      puts "\nTime is up!\a" # added \a for an audible beep
    end

  end

end
