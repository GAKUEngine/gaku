module Gaku
  class Syllabus < ActiveRecord::Base
    include Notes

    has_many :courses
    has_many :assignments
    has_many :lesson_plans

    has_many :syllabus_teachers
    has_many :teachers, through: :syllabus_teachers

    has_many :programs, class_name: 'Gaku::ProgramSyllabus'

    has_many :exam_syllabuses, dependent: :destroy
    has_many :exams, through: :exam_syllabuses

    belongs_to :department, required: false

    accepts_nested_attributes_for :exams, :assignments

    validates :name, :code, presence: true
  end
end
