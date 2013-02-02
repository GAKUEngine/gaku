require 'spec_helper'

describe Gaku::ClassGroup do

  context "validations" do
    it { should have_many :enrollments }
    it { should have_many(:students).through(:enrollments) }
    it { should have_many(:class_group_course_enrollments).dependent(:destroy) }
    it { should have_many(:courses).through(:class_group_course_enrollments) }

    it { should have_many(:semesters) }
    it { should have_many(:notes) }

    it { should validate_presence_of(:name) }

    it "is invalid without name" do
      FactoryGirl.build(:class_group, name: nil).should_not be_valid
    end
  end

end
