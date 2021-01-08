
puts "Enter how many minutes you want to set your timer for: "
timer = gets.chomp.to_i

now = Time.now
timerCount = timer * 60 # multiplied by 60 sec/min
divisions = 40
divPerSec = timerCount / divisions
endTime = now + timerCount
counter = 0
def spinner()
 while true # this while true statement never gets switched off in the loop below
  print("/")
  print("\b")
  print("|")
  print("\b")
  print("\\")
  print("\b")
 end
end

puts "Your #{timer} minute timer starts !t #{now}"

while now <= endTime do
  now += 1
  counter += 1
  if counter % divPerSec == 0 then printf("\rProgress: [%-40s]", "=" * (counter/divPerSec) )
  end
  sleep(1)
end

puts "\nTime is up!"
puts "EndTime was #{endTime} whereas the current time is: #{Time.now}"
