require 'spec_helper'

describe Gaku::Student do

  context "validations" do 
    it { should have_many(:admissions) }
  end
end
