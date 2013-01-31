module Gaku
  class ScholarshipStatus < ActiveRecord::Base
    has_many :students
    attr_accessible :name

    def to_s
      name
    end

  end
end
