require 'spec_helper'

describe Gaku::Note do

  context "validations" do 
  	it { should belong_to(:notable) }
  	#it { should belong_to(:lesson_plan) }
  end
  
end
