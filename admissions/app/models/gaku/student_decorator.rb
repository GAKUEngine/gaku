module Gaku
  Student.class_eval do
    has_one :admission

    #default_scope where("admitted != ?", "")

    scope :non_deleted, includes(:enrollment_status).where('gaku_enrollment_statuses.code != ?', "deleted")

    def student
      Student.unscoped{ super }
    end
  end
end
