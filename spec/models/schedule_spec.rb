require 'spec_helper'

describe Schedule do

  context "validations" do 
  	it { should have_valid_factory(:schedule) }
  	it { should have_many(:exam_portions) }
  end
  
end