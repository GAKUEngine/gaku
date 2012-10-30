require 'spec_helper'

describe Gaku::SimpleGrade do

  context "validations" do 
  	it { should belong_to :past_school }
  end
end
