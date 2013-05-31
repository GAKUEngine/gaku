module Gaku
  class School < ActiveRecord::Base

    include Picture

    has_many :campuses
    has_many :simple_grades
    has_many :levels
    has_many :programs

    attr_accessible :name, :is_primary, :slogan, :description, :founded,
                    :principal, :vice_principal, :grades, :code,
                    :levels_attributes

    validates :name, presence: true

    has_one :master_campus,
            -> { where is_master: true },
            class_name: Gaku::Campus,
            dependent: :destroy

    accepts_nested_attributes_for :levels, allow_destroy: true

    after_create :build_default_campus

    def to_s
      name
    end

    def primary?
      is_primary
    end

    def self.primary
      where(is_primary: true).first
    end

    private

    def build_default_campus
      if campuses.any?
        campus = campuses.first
      else
        campus = campuses.create(name: name)
      end

      campus.is_master = true
      campus.save
    end

  end
end
