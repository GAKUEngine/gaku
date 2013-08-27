module Gaku
  Student.class_eval do
    has_one :admission

    #default_scope where("admitted != ?", "")

    scope :non_deleted, -> { includes(:enrollment_status).where('gaku_enrollment_statuses.code != ?', 'deleted') }

    #validates :enrollment_status_id, presence: true

    def student
      Student.unscoped { super }
    end

    def self.only_applicants
      where(enrollment_status_code: Gaku::EnrollmentStatus.find_by_code('applicant').code)
    end

    def make_applicant
      update_column(:enrollment_status_code, Gaku::EnrollmentStatus.where(
                                                                    code:'applicant',
                                                                    is_active:false, 
                                                                    immutable:true).first_or_create!.code)
      save
    end

    def make_admitted(admission_date)
      update_column(:enrollment_status_code, Gaku::EnrollmentStatus.where(
                                                                    code:'admitted',
                                                                    is_active:true, 
                                                                    immutable:true).first_or_create!.code)
      update_column(:admitted, admission_date)
      save
    end
    
  end
end
