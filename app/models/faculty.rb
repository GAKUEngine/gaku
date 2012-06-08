class Faculty < ActiveRecord::Base
  has_many :roles 
  has_many :students
end
