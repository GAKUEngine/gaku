module Gaku
  class StudentGuardian < ActiveRecord::Base
    belongs_to :student, counter_cache: :guardians_count
    belongs_to :guardian

    validates :student_id, uniqueness: { scope: :guardian_id }
  end
end
