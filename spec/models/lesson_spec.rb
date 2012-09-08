require 'spec_helper'

describe Lesson do

  context "validations" do 
  	it { should have_valid_factory(:lesson) }

    it { should belong_to(:lesson_plan) }
    it { should have_many(:attendances) } 
  end
end