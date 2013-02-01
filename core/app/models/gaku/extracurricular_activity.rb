module Gaku
  class ExtracurricularActivity < ActiveRecord::Base
    has_many :extracurricular_activity_enrollments
    has_many :students, :through => :extracurricular_activity_enrollments

    attr_accessible :name

    validates_presence_of :name

    def to_s
      name
    end

  end
end
