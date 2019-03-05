require 'pry'

class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    student_hash.each {|key, value| self.send(("#{key}="), value)}
    @@all << self 
  end
  
  def self.create_from_collection(students_array)
    students_array.each do |student| 
      self.new(student)
    end
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |symbol|
      attributes_hash[symbol[0]] = symbol[1]
    end 
  end

  def self.all
    
  end
end

