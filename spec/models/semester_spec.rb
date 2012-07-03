require 'spec_helper'

describe Semester do

  context "validations" do 
  	it { should have_valid_factory(:semester) }
  end
  
end