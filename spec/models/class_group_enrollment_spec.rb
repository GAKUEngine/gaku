require 'spec_helper'

describe ClassGroupEnrollment do
  context "validations" do 
    it { should belong_to(:class_group) }
    it { should belong_to(:student) }
  end
end