require 'spec_helper'

describe Exam do

  context "validations" do 
  	let(:exam) { stub_model(Exam) }

    it { should have_valid_factory(:exam) }
    it { should have_many(:exam_scores) }
    it { should have_many(:exam_portions) }
    it { should have_many(:exam_portion_scores) }
    it { should have_and_belong_to_many(:syllabuses) } 
    it { should belong_to(:schedule) }

    it { should validate_presence_of(:name) }

    it "errors when name is nil" do
      exam.name = nil
      exam.should_not be_valid
    end
    
  end
  
end# == Schema Information
#
# Table name: exams
#
#  id             :integer         not null, primary key
#  name           :string(255)
#  description    :text
#  problem_count  :integer
#  max_score      :float
#  weight         :float
#  data           :binary
#  execution_date :datetime
#  created_at     :datetime        not null
#  updated_at     :datetime        not null
#  schedule_id    :integer
#

