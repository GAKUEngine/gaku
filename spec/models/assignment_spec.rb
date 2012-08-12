# == Schema Information
#
# Table name: assignments
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  description       :text
#  max_score         :integer
#  syllabus_id       :integer
#  grading_method_id :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'spec_helper'

describe Assignment do

  context "validations" do 
  	it { should have_valid_factory(:assignment) }
  	it { should belong_to(:syllabus) }
  	it { should belong_to(:grading_method) }
  end
  
end
