# works with long main menu and one sub menu
# sleep calculator - works
# sleep feedback - works
# to work on login

require 'time'
require 'date'
require 'terminal-table'

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
    puts "1. Wake Up Time"
    puts "2. Sleep feedback"
    puts "3. Sleep Time"
    puts "4. Exit"
  end

  def run
    exit = false
    until exit do
      cls
      ask
      menu_input = gets.chomp.to_i

      if menu_input == 1
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
        sl = 'sl.txt'
        sleep_file = open(sl, 'r+')
        sleep_length = sleep_file.read.to_i


        # creates time as an object
        time = Time.new
        #grabs todays date then adds one to get next day
        next_day = time.day + 1

        # sets t as tomorrows date at 8am (format is hh,m,m)
        t = Time.new(time.year, time.month, next_day, "#{wake_hr}", "#{wake_mins}")
        # calculates the date and time in seconds before the above defined time
        # time - sleep_length - time to fall asleep
        sleep_at = t - sleep_length
        sleep_file.close
        cls

        # display_min = 'time_converted'.tr(',', '')
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

      elsif menu_input == 2
        cls
        puts "Sleep feedback"

        sbm = SubMenu.new
        sbm.run

        sleep (0.5)
        # display sleep time

      elsif menu_input == 3
        cls

        st = 'st.txt'
        s_time = open(st, 'r+')
        print "You should sleep at #{s_time.read.to_s}"
        s_time.close
        puts ""
        puts ""
        puts ""
        break

      elsif menu_input == 4
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
  end

  def run
     exit = false
     until exit do
      ask
      menu_input = gets.chomp.to_i

      if menu_input  == 1
        cls
        puts "No adjustment needed"
        exit = true

      elsif menu_input == 2
        cls
        puts "sleep time adjusted + 10 mins" # adjust sleep length + 10 mins

        wh = 'wh.txt'
        alarm_hr = open(wh, 'r+')

        wm = 'wm.txt'
        alarm_min = open(wm, 'r+')

        time = Time.new
        next_day = time.day + 1

        # read sl file for sleep length
        sl = 'sl.txt'
        sleep_file = open(sl, "a+")
        sleep_length = sleep_file.read

        new_sleep_length = sleep_length.to_i + 600
        sleep_time = Time.new(time.year, time.month, next_day,"#{alarm_hr.read}", "#{alarm_min.read}")
        alarm_hr.close
        alarm_min.close
        puts new_sleep_length
        update_time = sleep_time - new_sleep_length

        sleep_file.write("\n")
        sleep_file.rewind
        sleep_file.write("#{new_sleep_length}")
        sleep_file.close
        # opens sleep time file
        st = 'st.txt'
        s_time = open(st, "r+" "t")
        s_time.write("#{update_time}")
        s_time.close

        sleep (2.0)
        exit = true

      else
        puts "Select from menu"
      end
    end
  end
end

def cls
  system 'cls'
end

alm = Alarms.new("","","")

user_file = 'uf.txt'
user_list = open(user_file, 'a+')

menu = MainMenu.new
menu.run
