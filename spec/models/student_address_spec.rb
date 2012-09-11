require 'spec_helper'

describe StudentAddress do

  context "validations" do 
    it { should have_valid_factory(:student_address) }
    it { should belong_to(:address) }
    it { should belong_to(:student) }
  end
  
end
