module Gaku
  class Program < ActiveRecord::Base

    has_many :program_specialties
    has_many :specialties, through: :program_specialties

    has_many :program_levels
    has_many :levels, through: :program_levels

    has_many :program_syllabuses
    has_many :syllabuses, through: :program_syllabuses

    belongs_to :school

    # attr_accessible :name, :description,
    #                 :program_specialties_attributes,
    #                 :program_levels_attributes,
    #                 :program_syllabuses_attributes

    validates :name, presence: true

    accepts_nested_attributes_for :program_levels,
                                  :program_specialties,
                                  :program_syllabuses,
                                  allow_destroy: true

  end
end
