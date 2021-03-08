class Pomodoro
  attr_accessor :minutes, :start, :future, :language, :run_time
  require_relative 'modules.rb'
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
    @start = Time.now
    @future = @start + convert_to_seconds(@minutes)

    start_timer

  end

  def start_timer
    if (self.language == 'es')
      puts @start.strftime("Tu Pom de #{@minutes} minutos comienza en %l:%M.")
    else
      puts @start.strftime("Your #{@minutes} minute timer starts at %l:%M.")
    end

    counter = 0
    # I'm refering to facsimilies of time (counter and timerCount)
    # because I don't know how to properly divide or find percentage of time objects
    # Likely could do more manipulations if convert Time objects .to_i

    # Also, if an odd number is chosen, ending percentage is 101%...
    # likely due to rounding.
    printf("Progress: [%-60s] 0%%","")
    while @start <= self.future do
      @start += 1
      counter += 1

      # basically this progress bar will add another bar (up to 60) every division of "timer"
      # print formatting performs a carriage return each time its written to create the illusion of movement
      # percentage complete is also listed at the end
      if counter % @minutes == 0 then printf("\rProgress: [%-60s] %d%%", "=" * (counter/@minutes), percent_of(counter, convert_to_seconds(@minutes)))
      end

      # To keeo the the program's ending time to less than 1.5% off of the actual ending time,
      # we update the counter every 2 minutes to reconcile any time drift.
      # if counter % 120 == 0 then @start = Time.now
      # end

      # This program's time drift occurs because of the sleep function used below.
      # I'm using this sleep function to essentially keep track of time passing,
      # this allows the program to perform significantly less operations than using
      # Time.now in realtime to update thousands of times.
      sleep(1)
    end

    @run_time = Time.now.to_i - @start.to_i

    if (self.language == 'es')
      puts "\nEl tiempo ha terminado!\a"
    else
      puts "\nTime is up!\a" # added \a for an audible beep
    end

  end

end
