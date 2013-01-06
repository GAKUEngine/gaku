module Gaku
	class Schedule < ActiveRecord::Base
    belongs_to :admission_period

	  attr_accessible :starting, :ending, :repeat
	end
end
