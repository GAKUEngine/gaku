require 'spec_helper'

describe Student do

  context "validations" do 
    let(:student) { stub_model(Student) }

  	it { should have_valid_factory(:student) }
    it { should have_many(:course_enrollments) }
    it { should have_many(:courses) }
    it { should have_many(:exams) }
    it { should have_many(:exam_scores) }
    it { should belong_to(:user) }
    it { should belong_to(:profile) }
    it { should have_many :class_group_enrollments }
    it { should have_many(:class_groups) } 
    it { should have_and_belong_to_many(:addresses) } 
    it { should have_and_belong_to_many(:guardians) }
    it { should have_many(:contacts) }
    it { should have_many(:notes) }

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:surname) }


    it "errors when name is nil" do
      student.name = nil
      student.should_not be_valid
    end

    it "errors when surname is nil" do
      student.surname = nil
      student.should_not be_valid
    end
  end
  
end# == Schema Information
#
# Table name: students
#
#  id              :integer         not null, primary key
#  name            :string(255)
#  surname         :string(255)
#  name_reading    :string(255)
#  surname_reading :string(255)
#  gender          :string(255)
#  phone           :string(255)
#  email           :string(255)
#  birth           :date
#  admitted        :date
#  graduated       :date
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  user_id         :integer
#  profile_id      :integer
#  faculty_id      :integer
#

