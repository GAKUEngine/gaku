require 'spec_helper'

describe Gaku::AdmissionPeriod do

  context "validations" do 
  
    it { should have_many :admissions }
    it { should have_many :admission_methods }
    
    it { should have_one  :schedule }

  end
end