require 'spec_helper'

describe Role do

  context "validations" do 
  	it { should have_valid_factory(:role) }
  	it { should belong_to(:class_group_enrollment) }
  	it { should belong_to(:faculty) }
  end
  
end
