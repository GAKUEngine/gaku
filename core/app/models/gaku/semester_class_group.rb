module Gaku
  class SemesterClassGroup < ActiveRecord::Base
    belongs_to :semester
    belongs_to :class_group

    attr_accessible :semester_id

    validates_presence_of :semester_id, :class_group_id


  end
end
