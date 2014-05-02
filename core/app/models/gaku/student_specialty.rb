module Gaku
  class StudentSpecialty < ActiveRecord::Base
    belongs_to :specialty
    belongs_to :student

    validates :specialty_id, presence: true

    validates :student_id,
              presence: true,
              uniqueness: { scope: :specialty_id,
                            message: I18n.t(:'specialty.already_added') }

    scope :ordered, -> { order('major desc') }
  end
end
