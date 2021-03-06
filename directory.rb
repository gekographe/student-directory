require "csv"

if ARGV.empty?
  ARGV << "students.csv"
end

@students =[]


def try_load_students
  filename = ARGV.first
  return if filename.nil?
  if File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end

def save_students
  puts "What would you name the file to save:"
  save_file = STDIN.gets.chomp
  CSV.open(save_file, "wb") do |csv|
    @students.each do |student|
      student_data = [student[:name], student[:cohort]]
      csv << student_data
    end
  end
end

def load_students(load_file = nil)
  if load_file.nil?
    puts "Which file would you like to load:"
    load_file = STDIN.gets.chomp
  end
  CSV.read(load_file).each do |name, cohort|
    adding_students_to_list(name, cohort)
  end
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish just hit return twice"
  name = STDIN.gets.chomp
  while !name.empty? do
    cohort = "november"
    adding_students_to_list(name, cohort)
    puts "Now we have #{@students.count} students"
    name = STDIN.gets.chomp
  end
end

def adding_students_to_list(name, cohort)
  @students << {name: name, cohort: cohort}
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to a file"
  puts "4. Load a list"
  puts "9. Exit"
end

def show_students
  print_header
  print_students_list
  print_footer
end

def process(selection)
  case selection
    when "1"
      puts "You asked for - Input Students -"
      input_students
      puts "Thank you! Waiting for a new selection:"
    when "2"
      puts "You asked for - Show the Students -"
      show_students
      puts "Thank you! Waiting for a new selection:"
    when "3"
      puts "You asked for - Save the list to a file -"
      save_students
      puts "Thank you! Waiting for a new selection:"
    when "4"
      puts "You asked for - Load a list -"
      load_students
      puts "Thank you! Waiting for a new selection:"
    when "9"
      puts "You are exiting the program, goodbye !"
      exit
    else
      puts "I don't know what you meant, try again:"
  end
end

def print_header
  puts "The students of Villains Academy"
  puts "--------------"
end

def print_students_list
  @students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students."
end

try_load_students
interactive_menu
