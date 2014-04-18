module Gaku
  class ExtracurricularActivity < ActiveRecord::Base
    has_many :enrollments, class_name: 'Gaku::ExtracurricularActivityEnrollment'
    has_many :students, through: :enrollments

    validates :name, presence: true, uniqueness: true

    def to_s
      name
    end
  end
end
