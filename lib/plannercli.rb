require 'pry'

class PlannerCLI

def greeting
puts "We've got 6 big months ahead of us, it's festival season baby!!!!\n\n"
menu
end

def menu
  puts "What's your festival availabilty?\n\n"
  puts "1. Instructions"
  puts "2. View festivals"
  puts "3. Add festivals to planner"
  puts "4. View your schedule"
  puts "5. View the squads schdeule"
  puts "6. Exit"
  main_menu_loop
end

def main_menu_loop
  binding.pry
  user_input = get.chomp
  loop do
     case user_input
    when 1
      puts "keep looping"
    when 2
      puts "keep looping"
    when 3
      puts "keep looping"
    when 4
      puts "keep looping"
    when 5
      puts "keep looping"
    when 6
      puts "Put the camera down and enjoy yourself"
      break
      end
    end
  end
end
