require 'spec_helper'

describe Gaku::AdmissionMethod do

  context "validations" do 
  	it { should have_many :admission_phases }
  	it { should belong_to :admission }
  end
end
