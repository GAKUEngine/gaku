module Gaku
  class Program < ActiveRecord::Base

    has_many :program_specialties
    has_many :specialties, :through => :program_specialties

    has_many :program_levels
    has_many :levels, :through => :program_levels

    has_many :syllabuses, :class_name => "Gaku::ProgramSyllabus"

    belongs_to :school

    attr_accessible :name, :description

    validates :name, :presence => true
  end
end
