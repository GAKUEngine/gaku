module Gaku
  Student.class_eval do
    has_one :admission

    #default_scope where("admitted != ?", "")

    scope :non_deleted, includes(:enrollment_status).where('gaku_enrollment_statuses.code != ?', "deleted")

    def student
      Student.unscoped{ super }
    end

    def self.only_applicants
      where(enrollment_status_id: Gaku::EnrollmentStatus.find_by_code('applicant').id)
    end

    def make_applicant
      update_column(:enrollment_status_id, Gaku::EnrollmentStatus.where(
                                                                    code:"applicant", 
                                                                    name:"Applicant", 
                                                                    is_active:false, 
                                                                    immutable:true).first_or_create!.id)
      save
    end

    def make_admitted(admission_date)
      update_column(:enrollment_status_id, Gaku::EnrollmentStatus.where(
                                                                    code:"admitted", 
                                                                    name:"Admitted", 
                                                                    is_active:true, 
                                                                    immutable:true).first_or_create!.id)
      update_column(:admitted, admission_date)
      save
    end
    
  end
end
