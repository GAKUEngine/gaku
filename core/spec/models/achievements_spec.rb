require 'spec_helper'

describe Gaku::Achievement do

  context "validations" do 
  	it { should belong_to :student }
  	it { should belong_to :school }
  end
end
