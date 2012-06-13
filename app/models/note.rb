class Note < ActiveRecord::Base
  belongs_to :student
  
  attr_accessible :title, :content
end