module Gaku
  class ExamSession < ActiveRecord::Base

    include Enrollable, Gradable

    belongs_to :exam

    validates :exam_id, presence: true

    def to_s
      name
    end
  end
end
