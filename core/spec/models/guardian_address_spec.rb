require 'spec_helper'

describe Gaku::GuardianAddress do

  context "validations" do 
    it { should belong_to(:address) }
    it { should belong_to(:guardian) }
  end
  
end
