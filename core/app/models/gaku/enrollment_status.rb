module Gaku
	class EnrollmentStatus < ActiveRecord::Base

    has_many :students

		translates :name

    attr_accessible :code, :name, :is_active, :immutable

    validates :code, presence: true

    before_create :check_status_name

    def check_status_name
    	if self.name.nil?
    		self.name = self.code
    	end
    end

    def to_s
      name
    end

  end
end
