module Gaku
  class Semester < ActiveRecord::Base
    attr_accessible :starting, :ending

    has_many :semester_courses
    has_many :courses, :through => :semester_courses

    has_many :semester_class_groups
    has_many :class_groups, :through => :semester_class_groups

    belongs_to :school_year

    validates_presence_of :starting, :ending

    validate :between_school_year_dates
    validate :ending_after_starting

    def to_s
      #"#{starting} - #{ending}"
      "#{starting} / #{ending}"
    end

    private

    def ending_after_starting
      return if  starting.blank? && ending.blank?
      errors.add(:base, I18n.t('semester.ending_after_starting')) if self.starting >= self.ending
    end

    def between_school_year_dates
      return if school_year.nil?
      school_year_range = school_year.starting..school_year.ending
      unless school_year_range.cover?(starting) && school_year_range.cover?(ending)
        errors.add(:base, I18n.t('semester.between'))
      end
    end
  end
end
