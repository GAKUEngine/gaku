require 'spec_helper'

describe ExamScore do

  context "validations" do 
  	it { should have_valid_factory(:exam_score) }
    it { should belong_to(:exam) }
    it { should belong_to(:student) }
  end
  
end# == Schema Information
#
# Table name: exam_scores
#
#  id         :integer         not null, primary key
#  score      :float
#  comment    :text
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  exam_id    :integer
#  student_id :integer
#

