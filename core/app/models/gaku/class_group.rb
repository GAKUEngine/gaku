module Gaku
  class ClassGroup < ActiveRecord::Base

    include Notes, Pagination, Enrollmentable, Semesterable

    validates :name, presence: true

    def to_s
      "#{grade} - #{name}"
    end

  end
end
