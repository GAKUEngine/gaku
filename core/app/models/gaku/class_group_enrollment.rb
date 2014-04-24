module Gaku
  class ClassGroupEnrollment < ActiveRecord::Base

    belongs_to :class_group
    belongs_to :enrollmentable, polymorphic: true
    has_many :school_roles, as: :school_rolable

    validates :enrollmentable_type, :enrollmentable_id, :class_group_id, presence: true

    validates :class_group_id,
       uniqueness: {
                     scope: [ :enrollmentable_type, :enrollmentable_id ],
                     message: I18n.t(:'class_group.already_enrolled')
                   }

    validates :enrollmentable_type,
      inclusion: {
        in: %w(Gaku::Course),
        message: "%{value} is not a valid"
      }

  end
end
