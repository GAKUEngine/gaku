module Gaku
  class ExamPortionScore < ActiveRecord::Base
    belongs_to :student
    belongs_to :exam_portion

    belongs_to :gradable, polymorphic: true

    has_many :attendances, as: :attendancable

    validates :student, :exam_portion, presence: true

    scope :gradable_scope, ->(gradable) { where(gradable: gradable) }
  end
end
