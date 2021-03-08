require_relative './classes/user.rb'
require_relative './classes/pomodoro.rb'

puts "  ___  ___  __  __   ___  ___  ___ __  __ "
puts ' | _ \/ _ \|  \/  | | _ \/ _ \| __|  \/  |'
puts ' |  _/ (_) | |\/| | |  _/ (_) | _|| |\/| |'
puts ' |_|  \___/|_|  |_| |_|  \___/|___|_|  |_|'
puts "  ~ Created by Jamison Griffith - 2021 ~  "
print "\n"

# Pom Poem has 3 main elements: user preferences, pomodoro timer, and poem generation.
# NOTE: Pom Poem is designed to hold basic user preferences and the user must provide name and
# preferred language (English or Spanish) to use the program.

# User information is stored in a local file named 'config.txt' and the validation
# module ensures this data stays uncorrupted. If config.txt is drastically manipulated,
# Pom Poem will delete the corrupted file and generate a new one.


user = User.new # checks for valid config.txt file, if not generates a new one
language = user.language # getting language so Pomodoro class can use (more elegant way?)

user.welcome_user # welcomes user with their name and time in preferred language.


# A Pomodoro timer is typically meant to sustain focused work for around 20 - 30 minutes.
# NOTE: the Terminal window has to be a roomy 76 columns wide for the progress bar to output correctly.

# This code is a work in progress and is currently not *very* accurate time-wise.
# I have added a time discrepancy output (English only) when the timer function is complete.
# Although since this is a Pomodoro timer it doesn't matter that it's a couple seconds off.
Pomodoro.new(language)


# let the user choose what they want to do next
decision = false

# NOTE: this is an infinite loop, user only exits program if they select "2" for the prompt
while decision == false do
  user.choose_option
end
