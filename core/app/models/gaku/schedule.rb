# == Schema Information
#
# Table name: schedules
#
#  id         :integer          not null, primary key
#  starting   :datetime
#  ending     :datetime
#  repeat     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
module Gaku
	class Schedule < ActiveRecord::Base
    belongs_to :admission_period
    
	  attr_accessible :starting, :ending, :repeat 
	end
end
