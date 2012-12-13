require 'spec_helper'

describe Gaku::Role do

  context "validations" do 
  	it { should belong_to(:class_group_enrollment) }
  	it { should belong_to(:faculty) }
  end
  
end
