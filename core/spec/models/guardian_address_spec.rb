require 'spec_helper'

describe GuardianAddress do

  context "validations" do 
    it { should have_valid_factory(:guardian_address) }
    it { should belong_to(:address) }
    it { should belong_to(:guardian) }
  end
  
end
