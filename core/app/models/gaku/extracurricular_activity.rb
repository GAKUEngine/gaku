module Gaku
  class ExtracurricularActivity < ActiveRecord::Base

    include Trashable

    has_many :enrollments, class_name: 'Gaku::ExtracurricularActivityEnrollment'
    has_many :students, through: :enrollments

    validates :name, presence: true

    def to_s
      name
    end

  end
end
