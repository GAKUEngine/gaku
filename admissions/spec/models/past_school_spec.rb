require 'spec_helper'

describe Gaku::PastSchool do

  context "validations" do 
  	it { should belong_to :school }
  end
end
