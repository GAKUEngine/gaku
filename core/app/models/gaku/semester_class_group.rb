module Gaku
  class SemesterClassGroup < ActiveRecord::Base
    belongs_to :semester
    belongs_to :class_group

    attr_accessible :semester_id

    validates_presence_of :semester_id, :class_group_id

    validates :semester_id,
              presence: true,
              uniqueness: {
                            scope: :class_group_id,
                            message: I18n.t(:'semester_class_group.uniqueness')
                          }

    def self.group_by_semester
      all.includes([:semester, :class_group]).group_by(&:semester_id)
    end

  end
end
