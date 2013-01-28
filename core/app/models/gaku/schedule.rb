module Gaku
	class Schedule < ActiveRecord::Base
	  attr_accessible :starting, :ending, :repeat
	end
end
