# works with long main menu and one sub menu
# sleep calculator works
# to work on sleep feedback
# to work on login

require 'time'
require 'date'
require 'terminal-table'

class User
  def initialize(username,password)
    @username = username
    @password = password
  end
  attr_accessor :username, :password

  def auth
    puts "Please enter username"
    username = gets.chomp.to_s
    puts "Please enter password"
    password = gets.chomp.to_s
  end

  def user_list # write to array
    system "cls"
    @user_list = Hash.new
    rows = []
    table = []
    @user_list = Hash[username => password]
    @menu.each do |username,password|
      rows << [username,password]
    end
  end
end

class Alarms
  def initialize(wake_hr, wake_mins, sleep_length)
    @wake_hr = wake_hr
    @wake_mins = wake_mins
    @sleep_length = sleep_length
  end
  attr_accessor :wake_hr, :wake_mins, :sleep_length
end

# putting a menu in its own class makes it local. keeps variables reuseable and code more scalable and easier to work through logic.
class MainMenu
  def ask
    puts "Welcome to Sleep Tuner"
    puts "Please select"
    puts "1. Login"
    puts "2. Wake Up Time"
    puts "3. Sleep feedback"
    puts "4. Sleep Time"
    puts "5. Create Account"
    puts "6. Exit"
  end

  def run
    exit = false
    until exit do
      cls
      ask
      menu_input = gets.chomp.to_i

      if menu_input == 1
        #login.auth #capture login
        #work on authentication method
        cls
        puts "logged in"
        sleep (0.5)

      elsif menu_input == 2
        #if #password matches username key in password file then grant access.
        #end
        cls

        puts "Enter the time you need to wake up"
        puts "Format HH"
        wake_hr = gets.chomp.to_i

        # opens files needed to write time variables
        wh = 'wh.txt'
        alarm_hr = open(wh, 'w+')
        alarm_hr.write("#{wake_hr}")
        alarm_hr.close

        puts "Format MM"
        wake_mins = gets.chomp

        # opens files needed to write time variables
        wm = 'wm.txt'
        alarm_min = open(wm, 'w+')
        alarm_min.write("#{wake_mins}")
        alarm_min.close

        # variable that changes to adjust amount of time you sleep (includes time needed to fall asleep)
        # starts at 7.5 hours + 15 mins (25200 + 900 = 26100)
        # (typical sleep cycle consisting of 1.5 hour blocks and average time needed to fall asleep)
        sleep_length = 27900

        # creates time as an object
        time = Time.new
        #grabs todays date then adds one to get next day
        next_day = time.day + 1

        # sets t as tomorrows date at 8am (format is hh,m,m)
        t = Time.new(time.year, time.month, next_day, "#{wake_hr}", "#{wake_mins}")
        # calculates the date and time in seconds before the above defined time
        # time - sleep_length - time to fall asleep
        sleep_at = t - sleep_length.to_i
        cls

        display_min = 'time_converted'.tr(',', '')
        puts "Your desired wake up time is #{wake_hr}:#{wake_mins} am"
        print "You should sleep at #{sleep_at}"
        st = 'st.txt'
        s_time = open(st, 'r+')
        s_time.write("#{sleep_at}")
        s_time.close
        puts ""
        puts ""
        puts ""
        break

      elsif menu_input == 3
        cls
        puts "Sleep feedback"

        sbm = SubMenu.new
        sbm.run

        sleep (0.5)
        # display sleep time
      elsif menu_input == 4
        cls

        st = 'st.txt'
        s_time = open(st, 'r+')
        print "You should sleep at #{s_time.read.to_s}"
        s_time.close
        puts ""
        puts ""
        puts ""
        break

      elsif menu_input == 5
        # login.auth # capture login
        # userlist = []
        # user_list.write["#{login.auth.@username},#{login.auth.@password}"]
        # user_list.close
        cls
        puts "create account"
        username = 'chi'
        puts "#{username} created"
        sleep (1.5)

      elsif menu_input == 6
        cls
        puts "Thanks for using Sleep Tune. Exiting"
        exit = true
        sleep (0.5)

      else
        cls
        puts "Please select from menu"
      end
    end

  end
end

class SubMenu
  def initialize
  end

  def ask
    puts "How did you sleep last night"
    puts "Please select"
    puts "1. Good"
    puts "2. Bad"
    puts "3. Exit"
  end

  def run
    exit = false
    until exit do
      ask
      menu_input = gets.chomp.to_i

      if menu_input  == 1
        cls
        puts "No adjustment needed"

      elsif menu_input == 2
        cls
        puts "sleep time adjusted + 10 mins" # adjust sleep length + 10 mins

      elsif menu_input == 3
        cls
        puts "Exiting"
        exit = true

      else
        puts "Select from menu"
      end
    end
  end
end

# class OpenFiles
#   # def initialize
#   # end
#   def opf
#     # opens files needed to write time variables
#     wm = 'wm.txt'
#     alarm_min = open(wm, 'w+')
#
#     wh = 'wh.txt'
#     alarm_hr = open(wh, 'w+')
#   end
# end

def cls
  system 'cls'
end

login = User.new("","")
alm = Alarms.new("","","")

user_file = 'uf.txt'
user_list = open(user_file, 'a+')

menu = MainMenu.new
menu.run
