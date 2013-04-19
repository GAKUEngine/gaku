module Gaku
  class SchoolYear < ActiveRecord::Base

    attr_accessible :starting, :ending
    has_many :semesters

    validates_presence_of :starting, :ending

    validate :ending_after_starting

    private

    def ending_after_starting
      return if  starting.blank? && ending.blank?
      if starting >= ending
        errors.add(:ending, I18n.t(:'school_year.ending_after_starting'))
      end
    end

  end
end
