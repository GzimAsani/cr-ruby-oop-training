#!/usr/bin/env ruby
# rubocop:disable Metrics/CyclomaticComplexity

require_relative './book'
require_relative './person'
require_relative './student'
require_relative './teacher'
require_relative './rental'

class App
  def initialize()
    @books = []
    @people = []
    @rentals = []
  end

  def prompt(message)
    print message
    gets.chomp
  end

  def list_books
    @books.each do |book|
      print "Title: \"#{book.title}\", Author: #{book.author} \n"
    end
  end

  def list_people
    @people.map do |person|
      prefix = person.is_a?(Student) ? '[Student]' : '[Teacher]'
      print "#{prefix} Name: \"#{person.name}\", Id: #{person.id}, Age: #{person.age} \n"
    end
  end

  def create_person
    print "Do you want to create a student (1) or a teacher (2)? [Input the number]: \n"
    person_type = gets.chomp

    age = prompt('Age: ')
    name = prompt('name: ')
    case person_type
    when '1'
      puts 'Has parent permission? [Y/N]: '
      parent_permission = gets.chomp
      parent_permission = parent_permission.downcase == 'y'
      @people << Student.new(age, parent_permission, name)
    when '2'
      puts 'Specilization: '
      specialization = prompt('Specialization: ')
      @people << Teacher.new(age, specialization, name)
    end
    puts 'Person created successfully'
  end

  def create_book
    title = prompt('Title: ')
    author = prompt('Author: ')
    @books << Book.new(title, author)
    puts 'Book created successfully'
  end

  def create_rental
    print "Select a book from the following list by number \n"
    @books.each_with_index do |book, index|
      puts "#{index}) ID: #{index}, Title: #{book.title}"
    end
    book_index = gets.chomp.to_i

    puts "\nSelect a person from the following list by number (not id)"
    @people.each_with_index do |person, index|
      puts "#{index}) [#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
    person_index = gets.chomp.to_i

    puts "\nDate"
    date = gets.chomp
    @rentals << Rental.new(date, @books[book_index], @people[person_index])
    puts 'Rental created successfully'
  end

  def list_rentals_for_person_id
    puts 'ID of person: '
    id = gets.chomp.to_i
    @people[id].rentals.each do |rental|
      puts "Date: #{rental.date}, Book \"#{rental.book.title}\" by #{rental.book.author} \n"
    end
  end
end

def options
  puts 'Please choose an option by entering a number'
  puts '1 - List all books'
  puts '2 - List all people'
  puts '3 - Create a person'
  puts '4 - Create a book'
  puts '5 - Create a rental'
  puts '6 - List all rentals for a given person id'
  puts '7 - Exit'
end

def dispatch(response, app)
  case response
  when '1'
    app.list_books
  when '2'
    app.list_people
  when '3'
    app.create_person
  when '4'
    app.create_book
  when '5'
    app.create_rental
  when '6'
    app.list_rentals_for_person_id
  when '7'
    puts 'Thank you for using this app!'
  end
end

# rubocop:enable Metrics/CyclomaticComplexity
