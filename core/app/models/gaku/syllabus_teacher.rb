class Gaku::SyllabusTeacher < ActiveRecord::Base
  belongs_to :teacher
  belongs_to :syllabus
end
