require 'spec_helper'

describe Gaku::AdmissionPeriod do

  context "validations" do 
    it "has a valid factory" do
      should have_valid_factory(:admission_period) 
    end
    it { should have_many :admissions }
    it { should have_many :admission_methods }
    
    it { should have_one  :schedule }

  end
end