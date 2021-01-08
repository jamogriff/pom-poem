
puts "Enter how many minutes you want to set your timer for: "
timer = gets.chomp.to_i

now = Time.now
timerCount = timer * 60 # multiplied by 60 sec/min
quarterTime = now + (timerCount/4)
halfTime = now + (timerCount/2)
endTime = now + timerCount

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

puts "Your #{timer} minute timer starts now!"

while now <= endTime do
  # spinner() gotta fix this spinner...
  now = Time.now
  # the following if/else's never execute because it's very unlikely the exact numbers 
  # will get enumerated when Time.now gets executed...
  if now == quarterTime 
    puts "You're 25% done."
  elsif now == halfTime
    puts "You're halfway there!"
  end
  false
end

puts "Time is up!"
