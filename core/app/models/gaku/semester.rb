module Gaku
  class Semester < ActiveRecord::Base

    has_many :semester_connectors
    with_options through: :semester_connectors, source: :semesterable do |assoc|
      assoc.has_many :courses, source_type: 'Gaku::Course'
      assoc.has_many :class_groups, source_type: 'Gaku::ClassGroup'
    end

    has_many :semester_attendances

    belongs_to :school_year

    validates :starting, :ending, presence: true

    validate :between_school_year_dates
    validate :ending_after_starting

    scope :with_class_group, -> { joins(:class_groups) }
    scope :active, -> { where('starting <= ? and ending >= ?', Date.today, Date.today) }
    scope :upcomming, -> { where('starting > ?', Date.today) }

    def to_s
      "#{starting} / #{ending}"
    end

    def active?
      starting <= Date.today && ending >= Date.today
    end

    def upcomming?
      starting > Date.today
    end

    def ended?
      ending < Time.now
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
