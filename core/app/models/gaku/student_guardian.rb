module Gaku
  class StudentGuardian < ActiveRecord::Base
    belongs_to :student, counter_cache: :guardians_count
    belongs_to :guardian
  end
end
