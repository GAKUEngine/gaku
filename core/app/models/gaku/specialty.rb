module Gaku
  class Specialty < ActiveRecord::Base
    has_many :student_specialties
    has_many :students, through: :student_specialties

    has_many :program_specialties
    has_many :programs, through: :program_specialties

    belongs_to :department

    validates :name, presence: true, uniqueness: true

    def to_s
      name
    end
  end
end
