module Gaku
  class ExternalSchoolRecord < ActiveRecord::Base
    belongs_to :school
    belongs_to :student, counter_cache: :external_school_records_count

    # has_many :simple_grades,
    #          -> { where("school_id = #{school_id} AND student_id = #{student_id}") },
    #          class_name: 'Gaku::SimpleGrade',
    #          dependent: :destroy

    validates :school, :student, presence: true

    def attendance_rate
      (presence_days.to_f / total_units) * 100 if units_values_present?
    end

    def presence_days
      total_units - units_absent if units_values_present?
    end

    private

    def units_values_present?
      units_absent.present? && total_units.present?
    end
  end
end
