class Student < ActiveRecord::Base
  validates :name, :presence => true
end
