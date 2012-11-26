require 'spec_helper'

describe Gaku::SchoolHistory do

  context "validations" do 
  	it { should belong_to :school }
  	it { should belong_to :student }
  end
end
