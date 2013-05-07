module Gaku
  module InlineHelper

    def commute_method_types_inline
      commute_method_types = []
      CommuteMethodType.includes(:translations).each do |e|
        commute_method_types << {value: e.id, text: e.name}
      end
      commute_method_types.to_json.html_safe
    end

    def enrollment_statuses_inline
      enrollment_status_types = []
      EnrollmentStatus.includes(:translations).each do |e|
        enrollment_status_types << {value: e.id, text: e.name}
      end
      enrollment_status_types.to_json.html_safe
    end

    def scholarship_statuses_inline
      scholarship_statuses = []
      ScholarshipStatus.includes(:translations).each do |e|
        scholarship_statuses << {value: e.id, text: e.name}
      end
      scholarship_statuses.to_json.html_safe
    end

  end
end
