module Gaku
  class ClassGroup < ActiveRecord::Base

    include Notes, Pagination, Enrollmentable, Semesterable, StudentReviewable

    validates :name, presence: true

    def self.for_select
      %w(active upcomming).map do |state|
        [state.humanize, send(state).map { |cg| [cg.to_s, cg.id] }]
      end
    end

    def self.active
      @active = joins(:semesters).merge(Gaku::Semester.active).uniq
    end

    def self.upcomming
      @upcomming = joins(:semesters).merge(Gaku::Semester.upcomming).uniq - active
    end

    def to_s
      "#{grade} - #{name}"
    end

  end
end
