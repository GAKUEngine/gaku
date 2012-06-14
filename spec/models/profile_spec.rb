require 'spec_helper'

describe Profile do

  context "validations" do 
  	let(:profile) { stub_model(Profile) }

  	it { should have_valid_factory(:profile) }

  	it "errors when name is nil" do
      profile.name = nil
      profile.should_not be_valid
    end

    it "errors when surname is nil" do
      profile.surname = nil
      profile.should_not be_valid
    end

    it "errors when email is nil" do
      profile.email = nil
      profile.should_not be_valid
    end
  end
  
end