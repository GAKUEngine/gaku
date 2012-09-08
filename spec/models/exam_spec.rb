# == Schema Information
#
# Table name: exams
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  description       :text
#  adjustments       :text
#  weight            :float
#  use_weighting     :boolean
#  grading_method_id :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'spec_helper'

describe Exam do

  context "validations" do 
  	let(:exam) { Factory(:exam) }

    it { should have_valid_factory(:exam) }
    it { should have_many(:exam_scores) }
    it { should have_many(:exam_portions) }
    it { should have_many(:exam_portion_scores) }
    it { should have_and_belong_to_many(:syllabuses) } 
    it { should belong_to(:grading_method) }
    it { should have_many(:attendances) } 

    it { should validate_presence_of(:name) }

    it { should allow_mass_assignment_of :use_weighting }

    it "errors when name is nil" do
      exam.name = nil
      exam.should_not be_valid
    end

    it "should validate weight is greater than 0" do
      exam.weight = -1
      exam.should be_invalid
    end

    it "should validate weight is 0" do
      exam.weight = 0
      exam.should be_valid
    end
  end
  
end
