require_relative 'classes.rb'

user = User.new
language = user.get_language

user.welcome_user


=begin
  ___                   _
 | _ \___ _ __  ___  __| |___ _ _ ___
 |  _/ _ \ '  \/ _ \/ _` / _ \ '_/ _ \
 |_| \___/_|_|_\___/\__,_\___/_| \___/
=end

# This is a simple program to simulate a Pomodoro timer.
# A Pomodoro timer is typically meant to sustain focused work for around 20 - 30 minutes.
# NOTE: the Terminal window has to be a roomy 76 columns wide for the progress bar to output correctly.

# This code is a work in progress and is currently not very accurate time-wise.
# I have added a time discrepancy output when the timer function is complete.
# Although since this is a Pomodoro timer it doesn't matter that it's a couple seconds off.

if (language == 'es')
  puts "Entras cuantos minutos quieres para tu Pomodoro: "
else
  puts "Enter how many minutes you want to set your Pomodoro for: "
end
print "> "
timer = gets.chomp.to_i

now = Time.now
timerCount = timer * 60 # multiplied by 60 sec/min
divisions = 60
divPerSec = timerCount / divisions # can pretty much remove this -- same as timer var
endTime = now + timerCount
counter = 0

# straightforward percentage function
class Numeric
  def percent_of(n)
    self.to_f / n.to_f * 100.0
  end
end


# I'm refering to facsimilies of time (counter and timerCount)
# because I don't know how to properly divide or find percentage of time objects
# Likely could do more manipulations if convert Time objects .to_i

# Also, if an odd number is chosen, ending percentage is 101%...
# likely due to rounding.

if (language == 'es')
  puts now.strftime("Tu Pom de #{timer} minutos comienza en %l:%M.")
else
  puts now.strftime("Your #{timer} minute timer starts at %l:%M.")
end

printf("Progress: [%-60s] 0%%","")
while now <= endTime do
  now += 1
  counter += 1

  # basically this progress bar will add another bar (up to 60) every division of "timer"
  # print formatting performs a carriage return each time its written to create the illusion of movement
  # percentage complete is also listed at the end
  if counter % divPerSec == 0 then printf("\rProgress: [%-60s] %d%%", "=" * (counter/divPerSec), counter.percent_of(timerCount))
  end
  # I'm using this sleep function to essentially keep track of time passing, it's not terribly accurate
  # although for the purposes of a Pomodoro timer it works fine (roughly 0.6% error)
  sleep(1)
end

if (language == 'es')
  puts "\nEl tiempo ha terminado!\a"
else
  puts "\nTime is up!\a" # added \a for an audible beep
  puts "Program performed #{counter} operations and was #{Time.now - endTime} seconds off the exact ending time."
end

user.choose_option
