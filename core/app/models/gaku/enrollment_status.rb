module Gaku
	class EnrollmentStatus < ActiveRecord::Base

    has_many :students

		translates :name

    attr_accessible :name, :is_active, :immutable

    validates :name, presence: true

    def to_s
      name
    end

  end
end
