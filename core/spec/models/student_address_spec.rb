require 'spec_helper'

describe Gaku::StudentAddress do

  context "validations" do 
    it { should belong_to(:address) }
    it { should belong_to(:student) }
  end
  
end
