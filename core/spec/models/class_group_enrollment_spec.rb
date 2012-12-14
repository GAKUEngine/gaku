require 'spec_helper'

describe Gaku::ClassGroupEnrollment do

  context "validations" do 
    it { should belong_to(:class_group) }
    it { should belong_to(:student) }
    it { should have_many(:roles) } 
  end
  
end
