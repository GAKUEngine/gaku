# == Schema Information
#
# Table name: grading_methods
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  method      :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe GradingMethod do

  context "validations" do 
  	it { should have_valid_factory(:grading_method) }
  	it { should have_one(:exam) }
  	it { should have_one(:exam_portion) }
  	it { should have_one(:assignment) }
  end
  
end
