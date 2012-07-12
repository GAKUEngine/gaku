require 'spec_helper'

describe ExamPortion do
	
  context "validations" do 
    it { should have_valid_factory(:exam_portion) }
    it { should belong_to(:exam) }
    it { should have_many(:exam_portion_scores) }
  end

end# == Schema Information
#
# Table name: exam_portions
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  max_score  :float
#  weight     :float
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  exam_id    :integer
#

