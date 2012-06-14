class Profile < ActiveRecord::Base
  attr_accessible :surname, :name, :name_reading, :email, :birth_date
  
  validates :surname, :name, :email, :presence => true
end