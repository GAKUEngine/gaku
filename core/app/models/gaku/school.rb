module Gaku
  class School < ActiveRecord::Base

    include Picture

  	has_many :campuses
    has_many :simple_grades
    has_many :school_levels

  	attr_accessible :name, :is_primary, :slogan, :description, :founded,
                    :principal, :vice_principal, :grades, :code, :school_levels_attributes

    validates_presence_of :name

    has_one :master_campus,
      :class_name => 'Gaku::Campus',
      :conditions => { :is_master => true },
      :dependent => :destroy

    accepts_nested_attributes_for :school_levels, :allow_destroy => true

    after_create :build_default_campus

  	def to_s
      name
    end

    def primary?
      self.is_primary
    end

    def self.primary
      where(:is_primary => true).first
    end

    private

    def build_default_campus
      if self.campuses.any?
        campus = self.campuses.first
      else
        campus = self.campuses.create(:name => self.name)
      end

      campus.is_master = true
      campus.save
    end

  end
end
