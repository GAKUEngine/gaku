require 'spec_helper'

describe Gaku::ClassGroupEnrollment do

  context "validations" do 
    it { should belong_to(:class_group) }
    it { should belong_to(:student) }
    it { should have_many(:roles) } 

    it { should validate_presence_of :class_group_id }

    it { should validate_uniqueness_of(:student_id).scoped_to(:class_group_id).with_message(/Already enrolled to the class group!/) }

  end
  
end
