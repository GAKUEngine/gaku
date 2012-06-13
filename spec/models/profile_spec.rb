require 'spec_helper'

describe Profile do

  context "validations" do 
  	let(:profile) { stub_model(Profile) }

  	it { should have_valid_factory(:profile) }

  	it "errors when first_name is nil" do
      profile.first_name = nil
      profile.should_not be_valid
    end

    it "errors when last_name is nil" do
      profile.last_name = nil
      profile.should_not be_valid
    end

    it "errors when email is nil" do
      profile.email = nil
      profile.should_not be_valid
    end
  end
  
end