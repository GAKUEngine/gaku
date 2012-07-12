require 'spec_helper'

describe Schedule do

  context "validations" do 
  	it { should have_valid_factory(:schedule) }
  	it { should have_many(:exams) }
  end
  
end# == Schema Information
#
# Table name: schedules
#
#  id         :integer         not null, primary key
#  starting   :datetime
#  ending     :datetime
#  repeat     :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

