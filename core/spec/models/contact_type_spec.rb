require 'spec_helper'

describe Gaku::ContactType do

  context "validations" do 
    it { should have_many(:contacts) }
  end
  
end
