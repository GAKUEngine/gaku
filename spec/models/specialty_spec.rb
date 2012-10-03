require 'spec_helper'

describe Specialty do

  context "validations" do 
  	it { should have_valid_factory(:specialty) }

    it { should have_many(:student_specialties) } 
    it { should have_many(:students) }
  end
end
