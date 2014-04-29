module Gaku
  class Program < ActiveRecord::Base
    has_many :program_specialties
    has_many :specialties, through: :program_specialties

    has_many :program_levels
    has_many :levels, through: :program_levels

    has_many :program_syllabuses
    has_many :syllabuses, through: :program_syllabuses

    belongs_to :school

    validates :name, :school, presence: true
    validates :name, uniqueness: true

    accepts_nested_attributes_for :program_levels,
                                  :program_specialties,
                                  :program_syllabuses,
                                  allow_destroy: true

    def to_s
      name
    end
  end
end
