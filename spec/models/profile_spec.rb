require 'spec_helper'

describe Profile do
  context "validations" do 
  	it { should have_valid_factory(:profile) }
  end
end