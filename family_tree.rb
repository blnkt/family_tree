require 'bundler/setup'
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)

def menu
  puts 'Welcome to the family tree!'
  puts 'What would you like to do?'

  loop do
    puts 'Press a to add a family member.'
    puts 'Press l to list all family members.'
    puts 'Press p to add parents'
    puts 'Press m to add spouse'
    puts "Press c to add child"
   # puts 'Press s to see who someone is married to.'
    puts 'Press e to exit.'

    case gets.chomp
    when 'a'
      add_person
    when 'l'
      list
    when 'p'
      add_parents
    when 'm'
      add_spouse
    when 'c'
      add_children
    when 's'
      show_marriage
    when 'e'
      exit
    end
  end
  main_menu
end

def add_person
  puts 'What is the first name of the family member?'
  first_name = gets.chomp
  puts 'What is the last name of the family member?'
  last_name = gets.chomp
  puts "What is the birthday of #{first_name} #{last_name}?"
  birthday = gets.chomp
  Person.create({:first_name => first_name, :last_name => last_name, :birthday => birthday})
  puts first_name + " was added to the family tree.\n\n"
end

def add_spouse
  list
  puts 'What is the first_name of the first spouse?'
  spouse1_first = (gets.chomp)
  puts 'What is the last_name of the first spouse?'
  spouse1_last = (gets.chomp)
  spouse1 = Person.find_or_create_by(first_name: spouse1_first, last_name: spouse1_last)

  puts 'What is the first_name of the second spouse?'
  spouse2_first = (gets.chomp)
  puts 'What is the last_name of the second spouse?'
  spouse2_last = (gets.chomp)
  spouse2 = Person.find_or_create_by(first_name: spouse2_first, last_name: spouse2_last)

  spouse1.update(spouse_id: spouse2.id)
  spouse2.update(spouse_id: spouse1.id)
  puts spouse1_first + " is now married to " + spouse2_first + "."
end

def add_parents
  list_spouses
  puts "What is the child's first name?"
  child_first = (gets.chomp)
  puts "What is the child's last name?"
  child_last = (gets.chomp)
  child = Person.find_or_create_by(first_name: child_first, last_name: child_last)
  Relationship.create(person_id: child.id)
  loop do
  puts "What is the first name of the parent?"
  parent_first = gets.chomp
  puts "What is the last name of the parent?"
  parent_last = gets.chomp
  parent = Person.find_or_create_by(first_name: parent_first, last_name: parent_last)
  Relationship.create(person_id: parent.id, child_id: child.id)
  child.parents << parent

  puts "Would you like to add another parent? (Y/N)"
  break if gets.chomp.upcase == 'N'
  end
end

def add_children
  list_spouses
  puts "What is the parent's first name?"
  parent_first = (gets.chomp)
  puts "What is the parent's last name?"
  parent_last = (gets.chomp)
  parent = Person.find_or_create_by(first_name: parent_first, last_name: parent_last)

  puts "What is the first name of the child?"
  child_first = gets.chomp
  puts "What is the last name of the child?"
  child_last = gets.chomp
  puts "What is the birthday?"
  birthday = gets.chomp
  child = Person.create(first_name: child_first, last_name: child_last, birthday: birthday)
  Relationship.create(person_id: child.id, parent_id: parent.id)
  parent.children << child
  if parent.spouse_id?
    Person.find_by(parent.spouse_id).children << child
  end
  puts child_first + " was added to the family tree.\n\n"
end

def list
  puts 'Here are all your relatives:'
  Person.order(last_name: :asc, first_name: :asc).each do |person|
    puts "#{person.id}: #{person.first_name} #{person.last_name} -- #{person.birthday}"
  end
  puts "\n"
end

def list_spouses
  spouses = []
  results = Person.where.not(spouse_id: '')
  results.each do |person|
    spouses << [person.id, person.spouse_id]
  end
  spouses.each do |couples|
    spouse1 = Person.find_by(id: couples.first)
    spouses.delete_if do |more_couples|
      spouse2 = Person.find_by(id: couples.last)
      spouse1 == spouse2
    end
  end
  binding.pry
  puts "#{spouse1.first_name} #{spouse1.last_name} & #{spouse2.first_name} #{spouse2.last_name}"
end


menu
