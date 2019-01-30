module Gaku
  class SemesterAttendance < ActiveRecord::Base
    belongs_to :student
    belongs_to :semester

    def self.grouped_for_table
      all.group_by(&:student_id).map do |k, v|
        [k, v.group_by(&:semester_id).map { |x, y| [x, y.first] }.to_h]
      end.to_h
    end
  end
end
