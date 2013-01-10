module Gaku
	class EnrollmentStatus < ActiveRecord::Base
    has_many :students

		attr_accessible :name, :is_active, :immutable

    validates_presence_of :name


    def to_s
      "#{name}"
    end


  end
end
