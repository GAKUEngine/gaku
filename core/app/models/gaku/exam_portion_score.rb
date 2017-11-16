module Gaku
  class ExamPortionScore < ActiveRecord::Base
    belongs_to :student, required: false
    belongs_to :exam_portion, required: false

    belongs_to :gradable, polymorphic: true, required: false

    has_many :attendances, as: :attendancable

    validates :student, :exam_portion, presence: true

    scope :gradable_scope, ->(gradable) { where(gradable: gradable) }
  end
end
