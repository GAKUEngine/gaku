require 'spec_helper'

describe Gaku::ClassGroup do

  context "validations" do 
  	it { should have_valid_factory(:class_group) }
  	it { should have_many :class_group_enrollments }
    it { should have_many(:students) }
    it { should have_many(:courses) }
    it { should have_many(:semesters) }
    it "is invalid without name" do
      FactoryGirl.build(:class_group, name: nil).should_not be_valid
    end
  end
  
end
