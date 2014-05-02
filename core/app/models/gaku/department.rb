module Gaku
  class Department < ActiveRecord::Base
    has_many :specialties
    has_many :syllabuses
    has_many :exams

    translates :name

    validates :name, presence: true, uniqueness: true

    def to_s
      name
    end
  end
end
