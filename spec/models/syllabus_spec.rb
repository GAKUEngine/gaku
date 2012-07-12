require 'spec_helper'

describe Syllabus do

  context "validations" do 
  	it { should have_valid_factory(:syllabus) }
    it { should have_many(:courses) }
    it { should have_many(:assignments) } 
    it { should have_and_belong_to_many(:exams) } 
  end
  
end
# == Schema Information
#
# Table name: syllabuses
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  code        :string(255)
#  description :text
#  credits     :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

