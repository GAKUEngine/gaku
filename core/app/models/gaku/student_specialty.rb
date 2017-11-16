module Gaku
  class StudentSpecialty < ActiveRecord::Base
    belongs_to :specialty, required: false
    belongs_to :student, required: false

    validates :specialty_id, presence: true

    validates :student_id,
              presence: true,
              uniqueness: { scope: :specialty_id,
                            message: I18n.t(:'specialty.already_added') }

    scope :ordered, -> { order('major desc') }
  end
end
