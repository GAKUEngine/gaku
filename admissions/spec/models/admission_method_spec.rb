require 'spec_helper'

describe Gaku::AdmissionMethod do

  context "validations" do 
    it "has a valid factory" do
      should have_valid_factory(:admission_method) 
    end
  	it { should have_many :admission_phases }
  	it { should have_many :admissions }
    it { should have_many :admission_periods }
  end
end