module Gaku
	class EnrollmentStatus < ActiveRecord::Base

    has_many :students

		translates :name

    attr_accessible :code, :name, :is_active, :immutable

    validates :code, presence: true

    def to_s
      name
    end

  end
end
