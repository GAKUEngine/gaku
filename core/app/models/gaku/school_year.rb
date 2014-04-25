module Gaku
  class SchoolYear < ActiveRecord::Base
    has_many :semesters

    validates :starting, :ending, presence: true

    validate :ending_after_starting

    def to_s
      "#{starting} - #{ending}"
    end

    private

    def ending_after_starting
      return if  starting.blank? && ending.blank?
      errors.add(:base, I18n.t(:'school_year.ending_after_starting')) if starting >= ending
    end
  end
end
