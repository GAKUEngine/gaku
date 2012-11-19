require 'spec_helper'

describe Gaku::Student do

  context "validations" do 
    it "has a valid factory" do
      should have_valid_factory(:student) 
    end
    it { should have_many(:admissions) }
  end
end
