require 'spec_helper'

describe Assignment do

  context "validations" do 
  	it { should have_valid_factory(:assignment) }
  	it { should belong_to(:syllabus) }
  end
  
end# == Schema Information
#
# Table name: assignments
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  description :text
#  max_score   :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  syllabus_id :integer
#

