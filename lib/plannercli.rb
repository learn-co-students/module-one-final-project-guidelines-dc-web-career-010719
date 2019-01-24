require 'pry'
require 'tty-font'
require 'pastel'

class PlannerCLI


#Greeting method and calls the menu
def greeting
  pastel = Pastel.new
  font = TTY::Font.new(:starwars)
  puts pastel.cyan(font.write("Plan-it_Fest!"))
  puts "\n\nWe've got six big months ahead of us, it's festival season baby!!!!\n\n"
  menu
end

# def menu
#   puts "What's your festival availabilty?\n\n"
#   puts "1. Instructions"
#   puts "2. View festivals"
#   puts "3. Add festivals to planner"
#   puts "4. Search for a schedule"
#   puts "5. View the team schdeule"
#   puts "6. Exit\n\n"
#   main_menu_loop
# end


#Intial menu when entering the command line
def menu
  prompt = TTY::Prompt.new
  @choice = prompt.select("Choose from the options below:") do |menu|
    menu.enum '.'
    menu.choice "Instructions", 1
    menu.choice "View festivals", 2
    menu.choice "Add festival(s) to planner", 3
    menu.choice "Search for a schedule", 4
    menu.choice "View the team schedule", 5
    menu.choice "Exit", 6
  end
  @choice
end


# def menu_no_loop
#   prompt = TTY::Prompt.new
#   @choice = prompt.select("Choose from the options below:") do |menu|
#     menu.enum '.'
#     menu.choice "Instructions", 1
#     menu.choice "View festivals", 2
#     menu.choice "Add festivals to planner", 3
#     menu.choice "Search for a schedule", 4
#     menu.choice "View the team schdeule", 5
#     menu.choice "Exit", 6
#   end
#   @choice
# end


#Loops through menu items
def main_menu_loop
  loop do
    # binding.pry
    case input = @choice
      when 1
        puts "keep looping"
      when 2
        self.return_all_festivals
        self.menu
      when 3
        self.add_festivals_to_planner
      when 4
        # puts "\nWhat's your first name?\n\n"
        # user_hash = {}
        # user_hash[:first_name] = gets.chomp.to_s
        # puts "\n\n"
        # puts "What's your last name?\n\n"
        # user_hash[:last_name] = gets.chomp.to_s
        puts "\n\n"
        user = self.create_or_find_user
        self.return_schedule(user)
      when 5
        self.return_all_schedules
      when 6
        puts "\nPut the camera down and enjoy yourself!\n\n"
        return
      else
        puts "Hmmm... 1-6, not #{input}, try again."
    end
  end
end

  #Puts out the all festivals and their information
  def return_all_festivals
    puts "\n\n-----------------------------------------------------------------------------------------------------\n\n"
    Festival.all.each_with_index.map do |festival, index|
      puts "#{index + 1}. Festival: #{festival.name} | |Cost: #{festival.cost}| Start Date: #{festival.start_date} | End Date: #{festival.end_date} | Location: #{festival.location}"
    end
  end

  #Loops through and creates festival schedule and puts it out when the user exits the loop
  def add_festivals_to_planner
     attendee = self.create_or_find_user
    loop do
    puts "Which festival do you want to attend?\n\n"
      festival = gets.chomp.to_s #Lollapalooza
      all_festivals = Festival.all.map {|festival| festival.name}
     # binding.pry
      if all_festivals.include?(festival)
        add_festival = self.find_festival(festival)
        puts "Name your trip\n\n"
        trip_name = gets.chomp
        Planner.create(name: trip_name, user: attendee, festival: add_festival)
      elsif "Exit"
        # binding.pry
        puts "Exiting..."
        puts "\n-----------------------------------------------------------------------------------------------------\n\n"
        puts "It's LIT!!!!\n"
        return_schedule(attendee)
        return
      else
        puts "We're not interested in #{festival}."
        end
      end
    end

    #If a user if found return the matching object, if not
    #create a new user
    def create_or_find_user
      user_hash = {}
      puts "\nFirst, we need a little information.\n\n"
      puts "What's your first name?\n\n"
      user_hash[:first_name] = gets.chomp.to_s
      puts "What's your last name?\n\n"
      user_hash[:last_name] = gets.chomp.to_s
      puts "What's your location? (format: City, State)\n\n"
      user_hash[:location] = gets.chomp.to_s
      new_user = User.find_or_create_by(user_hash)
      new_user
    end

    #Find the festival object from a festival name string
    def find_festival(festival)
      festival = Festival.all.find_by(name: festival)
      festival
    end

    #Return the festival schedule from a name string
    def return_schedule(user_hash)
      plans = Planner.all.select do |schedule|
        user_hash[:first_name] == schedule.user.first_name && user_hash[:last_name] == schedule.user.last_name
      end
        puts "\n\n"
        puts "#{user_hash[:first_name]} #{user_hash[:last_name]}'s Schedule:\n\n"
        plans.each_with_index.map do |event, index|
          puts "#{index + 1}. Trip Name: #{event.name} | Festival: #{event.festival.name} | Dates: #{event.festival.start_date} - #{event.festival.end_date} "
        end
        puts "\n\n"
        self.menu
    end

    def return_all_schedules
      Planner.all.each_with_index.map do |event, index|
        puts "#{index + 1}. Trip Name: #{event.name} | Festival: #{event.festival.name} | Dates: #{event.festival.start_date} - #{event.festival.end_date} "
      end
      puts "\n\n"
      self.menu
      puts "\n\n"
    end
end
