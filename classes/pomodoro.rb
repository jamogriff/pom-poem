# This class handles the time-tracking functionality of Pom-Poem

class Pomodoro
  attr_accessor :language, :timer_length, :start_time, :run_time, :program_length
  attr_reader :run_time_log, :end_percentage, :end_time, :seed, :branch
  require_relative 'modules.rb'
  require_relative 'poem.rb'
  include Math
  include Validation

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

    @timer_length = get_number # method lives in Validation module

    # CREATE RANDOM BRANCH
    # This part of the code generates a random seed which determines what branch gets
    # executed after the Pom finishes. This ensures more variety of poems being displayed.
    # A random quote is also displayed for the user to ponder before Pom starts
    upper_bound = 1000
    @seed = rand(upper_bound) # generate a random number up to upper_bound
    primes = sieve_of_eratosthenes(upper_bound) # create array of all prime numbers up to upper_bound
    determine_branch(@language, @seed, primes) # @branch is set in this method below

    count_down # simple countdown until start of Pom

    # BEGIN TIMER
    # The function below executes the timer. Details are in the method below.
    start_timer
  end


  # This method starts the timer and displays an ongoing progress bar during runtime.
  def start_timer

    @start_time = Time.now # keeping this var static is important to track time drift
    @run_time = @start_time # run_time is used as the variable that tracks time as the program runs
    @run_time_log = {0 => @run_time.to_i} # This hash is used to track whether run_time and counter stay synced throughout runtime.
    @end_time = @start_time + convert_to_seconds(@timer_length) # ex: adding 120 seconds to start time for 2 min timer

    # Initializing counter. Even though there are int properties of @run_time, a strict int counter
    # is extremely useful to make comparisons and enable progress bar and percentage.
    counter = 0

    print @start_time.strftime("\r#{@timer_length} minute Pom start: %l:%M %P")
    printf("\nProgress: [%-60s] 0%%","") # this prints a string with 60 open spaces in-between brackets

    # The strategy for time-keeping below is meant to be fairly efficient in terms
    # of lessening number of operation. The sleep method is used to keep track of time,
    # instead of a Time object. Operations should be fairly close to the amount of seconds
    # of timer_length as opposed to using Time.now in realtime to update tens of thousands of times.
    while @run_time <= @end_time do
      counter += 1
      @end_percentage = approx_percent(counter, convert_to_seconds(@timer_length)).round

      # This progress bar will update progress bar and percentage complete (up to 60 times) every division of timer_length.
      # i.e. A 20 minute timer will update the progress bar every 20 seconds.
      # Print formatting performs a carriage return each time its written to create the illusion of movement
      if (counter % @timer_length == 0)
        printf("\rProgress: [%-60s] %d%%", "=" * (counter/@timer_length), @end_percentage)
        @run_time = Time.now
      end

      # There is a slight time drift in the program (see below)
      # Updating run_time with actual time every 10 minutes allows time drift
      # to stay within 5 seconds of actual time.
      #if counter % 30 == 0 then @run_time = Time.now
      #end

      @run_time += 1 # increase runtime by 1 second

      # ATTENTION: This is only used for testing counter and run_time syncing.
      # Please remove before using, otherwise it creates a large hash for no reason
      # @run_time_log[counter] = @run_time.to_i

      # This program's time drift occurs because of the sleep function used below.
      sleep(1) # sleep for 1 second
    end

    # These var's is used in testing to determine how accurate timer was
    @program_length = Time.now - @start_time

    # Output to user
    if (self.language == 'es')
      puts "\nEl tiempo ha terminado!\a\n"
    else
      puts "\nTime is up!\a\n" # added \a for an audible beep
    end


    # Note that branch is passed into a new poem instance.
    # This determines the length of the random poem selected and subsequently
    # shown to the user. 
    Poem.new(@branch)

  end

  def determine_branch(lang, seed, primes)
    if lang == 'es'

      # a basic function that adds some randomness to the output
      if primes.include?(seed)
        print "🤘Sigan disfrutando"
        @branch = "cyan"
      elsif seed < 300
        print "Cierras los ojos y te concentras"
        @branch = "magenta"
      elsif seed > 600
        print "Tomas un respiro y lo sueltas lentamente"
        @branch = "yellow"
      else
        print "Imaginas tu meta"
        @branch = "black"
      end

    else
      # a basic function that adds some randomness to the output
      if primes.include?(seed)
        print "Keep on rocking in the free world.\n" # Neil Young
        @branch = "cyan"
      elsif seed < 300
        print "All great things had small beginnings.\n" # Englewood Mural
        @branch = "magenta"
      elsif seed > 600
        print "The journey of a thousand miles begins with one step.\n" # Lao Tzu
        @branch = "yellow"
      else
        print "Success is the sum of small efforts, repeated day in day out.\n" # Robert Collier
        @branch = "black"
      end

    end

  end

  def count_down
    print "\n"
    countdown = 5
    while countdown > 0 do
      print "\r#{@timer_length} minute Pom start: #{countdown}"
      countdown -= 1
      sleep(1)
    end
  end

end
