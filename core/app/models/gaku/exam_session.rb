module Gaku
  class ExamSession < ActiveRecord::Base

    include Enrollmentable

    belongs_to :exam

    validates :exam_id, presence: true

    def to_s
      name
    end
  end
end
