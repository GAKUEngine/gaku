module Gaku
  class ScholarshipStatus < ActiveRecord::Base
    has_many :students

    translates :name

    validates :name, presence: true, uniqueness: true

    def to_s
      name
    end
  end
end
