class ClassGroup < ActiveRecord::Base
  has_and_belongs_to_many :students
  attr_accessible :name
end