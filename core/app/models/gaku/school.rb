module Gaku
  class School < ActiveRecord::Base

  	has_many :campuses
    has_many :simple_grades

  	attr_accessible :name, :is_primary, :slogan, :description, :founded,
                    :principal, :vice_principal, :grades, :code

    validates_presence_of :name

    has_one :master_campus,
      :class_name => 'Gaku::Campus',
      :conditions => { :is_master => true },
      :dependent => :destroy

    after_create :build_default_campus

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
