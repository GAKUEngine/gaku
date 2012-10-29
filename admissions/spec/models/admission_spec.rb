require 'spec_helper'

describe Gaku::Admission do

  context "validations" do 
    it { should belong_to(:student) } 
  end
end
