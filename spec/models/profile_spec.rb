require 'spec_helper'

describe Profile do

  context "validations" do 
  	let(:profile) { stub_model(Profile) }
  	it { should have_valid_factory(:profile) }
  end
  
end