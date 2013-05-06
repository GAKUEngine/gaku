module Gaku
  class ExtracurricularActivity < ActiveRecord::Base
    has_many :enrollments, class_name: Gaku::ExtracurricularActivityEnrollment
    has_many :students, through: :enrollments

    attr_accessible :name

    validates :name, presence: true

    def to_s
      name
    end

  end
end
