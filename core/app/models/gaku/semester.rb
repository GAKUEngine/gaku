module Gaku
  class Semester < ActiveRecord::Base

    has_many :semester_courses
    has_many :courses, through: :semester_courses

    has_many :semester_class_groups
    has_many :class_groups, through: :semester_class_groups

    belongs_to :school_year

    validates :starting, :ending, presence: true

    validate :between_school_year_dates
    validate :ending_after_starting

    scope :with_class_group, -> { joins(:class_groups) }
    scope :active, -> { where('starting < ? and ending > ?', Time.now, Time.now) }

    def to_s
      "#{starting} / #{ending}"
    end

    private

    def ending_after_starting
      return if  starting.blank? && ending.blank?
      errors.add(:base, I18n.t(:'semester.ending_after_starting')) if starting >= ending
    end

    def between_school_year_dates
      return if school_year.nil?
      year_range = school_year.starting..school_year.ending
      unless year_range.cover?(starting) && year_range.cover?(ending)
        errors.add(:base, I18n.t(:'semester.between'))
      end
    end
  end
end
