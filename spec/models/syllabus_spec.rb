require 'spec_helper'

describe Syllabus do

  context "validations" do 
  	it { should have_valid_factory(:syllabus) }
    it { should have_many(:courses) }
  end
  
end
