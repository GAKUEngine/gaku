require 'spec_helper'

describe Gaku::Semester do

  context "validations" do 
  	it { should belong_to(:class_group) }
  end
  
end
