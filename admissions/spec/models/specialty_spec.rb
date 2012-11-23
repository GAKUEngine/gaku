require 'spec_helper'

describe Gaku::Specialty do

  context "validations" do 
    it "has a valid factory" do
      should have_valid_factory(:specialty) 
    end
  	it { should have_many :specialty_applications }
  end
end
