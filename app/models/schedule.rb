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

class Schedule < ActiveRecord::Base
  attr_accessible :starting, :ending, :repeat 
end
