require 'spec_helper'

describe Contact do

  context "validations" do 
  	it { should have_valid_factory(:contact) }
    it { should belong_to(:contact_type) }
    it { should belong_to(:student) }
    it { should belong_to(:guardian) }
  end
  
end