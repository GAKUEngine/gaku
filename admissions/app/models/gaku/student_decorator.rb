module Gaku
  Student.class_eval do
    has_one :admission

    #default_scope where("admitted != ?", "")

    def student
      Student.unscoped{ super }
    end

    def self.only_applicants
      where(enrollment_status_id: Gaku::EnrollmentStatus.find_by_code('applicant').id)
    end
  end
end
