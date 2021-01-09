
puts "Enter how many minutes you want to set your timer for: "
timer = gets.chomp.to_i

now = Time.now
timerCount = timer * 60 # multiplied by 60 sec/min
divisions = 60 
divPerSec = timerCount / divisions
endTime = now + timerCount
counter = 0

class Numeric
  def percent_of(n)
    self.to_f / n.to_f * 100.0
  end
end

# this is kind of a mess... 
# I'm refering to facsimilies of time (counter and timerCount) 
# because I don't know how to properly divide or find percentage of time
# will have to refine this code further,
# if an odd number is chosen, ending percentage is 101%...
puts now.strftime("Your #{timer} minute timer starts at %l:%M.")
printf("Progress: [%-60s] 0%%","")
while now <= endTime do
  now += 1
  counter += 1
  if counter % divPerSec == 0 then printf("\rProgress: [%-60s] %d%%", "=" * (counter/divPerSec), counter.percent_of(timerCount))
  end
  sleep(1)
end

puts "\nTime is up!\a"
puts "Time discrepancy was #{Time.now - endTime} seconds."
