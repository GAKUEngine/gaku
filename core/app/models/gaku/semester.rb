module Gaku
  class Semester < ActiveRecord::Base
    attr_accessible :starting, :ending

    has_many :semester_courses
    has_many :courses, :through => :semester_courses

    has_many :semester_class_groups
    has_many :class_groups, :through => :semester_class_groups

    belongs_to :school_year

    validates_presence_of :starting, :ending

    validate :ending_after_starting

    private

    def ending_after_starting
      return if  starting.blank? && ending.blank?
      errors.add(:ending, I18n.t('semester.ending_after_starting')) if self.starting >= self.ending
    end

  end
end
