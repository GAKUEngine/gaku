require 'spec_helper'

describe Gaku::AdmissionMethod do

  context "validations" do 
  	it { should have_many :admission_phases }
  	it { should have_many :admissions }
    it { should belong_to :admission_period }
  end
end