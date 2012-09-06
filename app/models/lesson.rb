class Lesson < ActiveRecord::Base
  belongs_to :lesson_plan
  has_many :attendances, :as => :attendancable
  
end