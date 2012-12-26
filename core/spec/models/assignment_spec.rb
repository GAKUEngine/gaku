require 'spec_helper'

describe Gaku::Assignment do

  context "validations" do

  	it { should belong_to(:syllabus) }
  	it { should belong_to(:grading_method) }

    it { should validate_presence_of(:name) }

    it 'is invalid without name' do
      build(:assignment, name: nil).should_not be_valid
    end

  end
  
end
