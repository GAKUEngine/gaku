module Gaku
  class School < ActiveRecord::Base

    include Picture

    has_many :campuses
    has_many :simple_grades
    has_many :levels
    has_many :programs

    validates :name, presence: true

    has_one :master_campus,
            -> { where master: true },
            class_name: Gaku::Campus,
            dependent: :destroy

    accepts_nested_attributes_for :levels, allow_destroy: true

    after_create :build_default_campus

    def to_s
      name
    end

    def primary?
      primary
    end

    def self.primary
      where(primary: true).first
    end

    private

    def build_default_campus
      if campuses.any?
        campus = campuses.first
      else
        campus = campuses.create(name: name)
      end

      campus.master = true
      campus.save
    end

  end
end
