module ClassGroupEnrollmentable
  extend ActiveSupport::Concern

  included do
    has_many :class_group_enrollments, as: :enrollmentable, dependent: :destroy
    has_many :class_groups, through: :class_group_enrollments
  end

end
