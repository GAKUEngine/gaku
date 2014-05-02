module Gaku
  class ExtracurricularActivity < ActiveRecord::Base

    include Enrollmentable

    validates :name, presence: true, uniqueness: true

    def to_s
      name
    end

  end
end
