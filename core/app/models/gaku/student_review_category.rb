module Gaku
  class StudentReviewCategory < ActiveRecord::Base

    validates :name, presence: true, uniqueness: true

    translates :name

    def to_s
      name
    end

  end
end
