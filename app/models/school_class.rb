class SchoolClass < ActiveRecord::Base
  has_one :syllabus
  has_one :schedule
  has_one :teacher
end
