require 'spec_helper'

describe ContactType do

  context "validations" do 
  	it { should have_valid_factory(:contact_type) }
    it { should have_many(:contacts) }
  end
  
end