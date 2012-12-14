require 'spec_helper'

describe Gaku::Achievement do

  context "validations" do 

    it { should belong_to :student }
    it { should belong_to :school }
    
    it { should validate_presence_of(:name) }
    
    it 'is invalid without name' do
      build(:achievement, name:nil).should_not be_valid
    end
  end
end
