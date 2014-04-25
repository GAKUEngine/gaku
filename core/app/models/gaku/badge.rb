module Gaku
  class Badge < ActiveRecord::Base
    belongs_to :student, counter_cache: :badges_count
    belongs_to :badge_type

    validates :badge_type_id, :student_id, presence: true
  end
end
