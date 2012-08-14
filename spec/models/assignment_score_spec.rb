# == Schema Information
#
# Table name: assignment_scores
#
#  id         :integer          not null, primary key
#  score      :integer
#  student_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe AssignmentScore do

  context "validations" do 
  	it { should have_valid_factory(:assignment_score) }
  	it { should belong_to(:student) } 
  end
  
end
