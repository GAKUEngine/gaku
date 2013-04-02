require 'spec_helper'

describe Gaku::ClassGroupEnrollment do

  context "validations" do
    it { should belong_to(:class_group) }
    it { should belong_to(:student) }
    it { should have_many(:roles) }

    it { should validate_presence_of :class_group_id }
    it { should validate_presence_of :student_id }

    it { should validate_uniqueness_of(:student_id).scoped_to(:class_group_id).with_message(/Already enrolled to the class group!/) }

  end


  context "#save_student_class_and_number" do
    let(:enrollment) { create(:class_group_enrollment) }

    it 'saves after creation' do
      enrollment
      enrollment.student.class_and_number.should eq "#{enrollment.class_group} - ##{enrollment.seat_number}"
    end
  end


end
