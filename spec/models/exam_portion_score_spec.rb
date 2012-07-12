require 'spec_helper'

describe ExamPortionScore do

  context "validations" do 
    it { should have_valid_factory(:exam_portion_score) }
    it { should belong_to(:exam_portion) }
  end
  
end# == Schema Information
#
# Table name: exam_portion_scores
#
#  id              :integer         not null, primary key
#  score           :float
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  exam_portion_id :integer
#

