require 'spec_helper'

describe Gaku::SpecialtyApplication do

  context "validations" do 
  	it { should belong_to :specialty }
  end
end
