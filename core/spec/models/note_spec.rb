require 'spec_helper'

describe Gaku::Note do

  context "validations" do 
  	it { should belong_to(:notable) }

    it { should validate_presence_of :title }
    it { should validate_presence_of :content }
  	
    it { should allow_mass_assignment_of :title }
    it { should allow_mass_assignment_of :content }

    it "is invalid without title" do
      build(:note, title: nil).should_not be_valid
    end

    it "is invalid without content" do
      build(:note, content: nil).should_not be_valid
    end
  end
  
end
