module Gaku
  class ScholarshipStatus < ActiveRecord::Base

    has_many :students

    translates :name

    attr_accessible :name

    validates :name, presence: true

    def to_s
      name
    end

  end
end
