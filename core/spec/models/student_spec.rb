require 'spec_helper'

describe Gaku::Student do

  context "validations" do
    let(:student) { stub_model(Gaku::Student) }

    it { should have_many :course_enrollments }
    it { should have_many(:courses).through(:course_enrollments) }
    it { should have_many :class_group_enrollments }
    it { should have_many(:class_groups).through(:class_group_enrollments) }
    it { should have_many :student_specialties }
    it { should have_many(:specialities).through(:student_specialties) }
    it { should have_many :exam_portion_scores }
    it { should have_many :assignment_scores }
    it { should have_many :addresses }
    it { should have_many :contacts }
    it { should have_many :notes }
    it { should have_many :attendances }
    it { should have_many :achievements }
    it { should have_many :school_histories }
    it { should have_many :simple_grades }

    it { should belong_to(:commute_method)}
    it { should belong_to(:user) }
    it { should belong_to :scholarship_status }
    it { should belong_to :enrollment_status }

    it { should have_and_belong_to_many(:guardians) }

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:surname) }

    it { should accept_nested_attributes_for(:guardians).allow_destroy(true) }

    it { should allow_mass_assignment_of(:name) }
    it { should allow_mass_assignment_of(:surname) }
    it { should allow_mass_assignment_of(:name_reading) }
    it { should allow_mass_assignment_of(:surname_reading) }
    it { should allow_mass_assignment_of(:birth_date) }
    it { should allow_mass_assignment_of(:gender) }
    it { should allow_mass_assignment_of(:admitted) }
    it { should allow_mass_assignment_of(:graduated) }
    it { should allow_mass_assignment_of(:class_groups) }
    it { should allow_mass_assignment_of(:class_group_ids) }
    it { should allow_mass_assignment_of(:class_groups_attributes) }
    it { should allow_mass_assignment_of(:guardians) }
    it { should allow_mass_assignment_of(:guardians_attributes) }
    it { should allow_mass_assignment_of(:picture) }
    it { should allow_mass_assignment_of(:student_id_number) }
    it { should allow_mass_assignment_of(:student_foreign_id_number) }
    it { should allow_mass_assignment_of(:scholarship_status_id) }
    it { should allow_mass_assignment_of(:enrollment_status_id) }
    it { should allow_mass_assignment_of(:is_deleted) }
    it { should_not allow_mass_assignment_of(:user) }
    it { should_not allow_mass_assignment_of(:user_attributes) }

    it "errors when name is nil" do
      student.name = nil
      student.should_not be_valid
    end

    it "errors when surname is nil" do
      student.surname = nil
      student.should_not be_valid
    end
  end

  context 'methods' do
    xit 'enrollment_status'
    xit 'to_s'
    xit 'scholarship'
    xit 'class_group_widget'
    xit 'seat_number_widget'
    xit 'address_widget'
    xit 'primary_address'
  end

end
