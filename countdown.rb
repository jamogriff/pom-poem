# This program performs a basic countdown using date objects.
# The target date is currently hard-coded and will only count weekdays

require 'date'

=begin
The .strftime method is a very useful method for formatting Time objects...
the following is a cheatsheet for the formats we can use with strftime:
  %d = day of the month (01..31) or use $-d for (1..31)
  %m = month of the year (01..12) or use $-m for (1..12)
  %k = hour (0..23)
  %M = minutes
  %S = seconds (00..60)
  %l = hour (1..12)
  %p = AM/PM
  %Y = year
  %A = day of the week (name)
  %B = month (name)
=end

now = Time.now
currentDay = now.to_date # changes into date object for manipulation
lastDay = Date.new(2021,2,26) # to make this program more widely applicable, you can have the user change this
daysLeft = 0 # used as a counter

# this loop decreases the target date by 1 and counts weekdays only
# There is apparently a business_time module to also do this,
# but I don't really need the overhead for this application.
while lastDay >= currentDay do
  daysLeft += 1 unless lastDay.saturday? or lastDay.sunday?
  lastDay -= 1
end

print("\n")
puts now.strftime("Guess what? It's currently %l:%M %p, %A %B %-d, which means...")
puts "There are only #{daysLeft} days left at your current position!!"
print("\n")


# MOTIVATIONAL RANDOM QUOTE
# This part of the code generates a random quote to go along with the countdown

random = rand(10000) # generate a random number up to 10k

# Fun Fact: This algorithm is known as the Sieve of Eratosthenes.
  def sieve(max)
    primes = (0..max).to_a

    primes[0] = primes[1] = nil # getting 0 and 1 out of the way

    primes.each do |p|
    # skip item if nil
      next unless p

      break if p*p > max # break loop if a perfect square exceeds max value

      # as we iterate through numbers, we square the value (e.g. 3*3)
      # then skip through the array by the value of p (i.e. by multiples of p).
      # Each multiple of p is assigned nil, and thus removed from the array.
      (p*p).step(max,p) {|m| primes[m] = nil}
    end

    primes.compact # compact method removes all of the nil entries
  end
 
primes = sieve(10000) # create array of all prime numbers < 10k

# a basic function that adds some randomness to the output
if primes.include?(random)
  puts "THANK THE LORD! This job is insufferable."
elsif random < 3000
  puts "Love the life you live. Live the life you love." # Bob Marley quote
elsif random > 6000
  puts "Cut my life into pieces. This is my last resort." # Papa Roach quote
else
  puts "You can do it!! :) You have survived less than this."
end

