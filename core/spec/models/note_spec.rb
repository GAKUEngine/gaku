require 'spec_helper'

describe Note do

  context "validations" do 
  	it { should have_valid_factory(:note) }

  	it { should belong_to(:notable) }
  	#it { should belong_to(:lesson_plan) }
  end
  
end
