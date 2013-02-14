require 'spec_helper'

describe Gaku::Student do

  context "validations" do

    it_behaves_like 'person'
    it_behaves_like 'addressable'
    it_behaves_like 'notable'
    it_behaves_like 'contactable'
    it_behaves_like 'avatarable'
    it_behaves_like 'thrashable'

    it { should have_many :course_enrollments }
    it { should have_many(:courses).through(:course_enrollments) }

    it { should have_many :class_group_enrollments }
    it { should have_many(:class_groups).through(:class_group_enrollments) }

    it { should have_many :student_specialties }
    it { should have_many(:specialties).through(:student_specialties) }

    it { should have_many :achievements }
    it { should have_many(:achievements).through(:student_achievements) }

    it { should have_many :exam_portion_scores }
    it { should have_many :assignment_scores }
    it { should have_many :attendances }
    it { should have_many :achievements }
    it { should have_many :external_school_records }
    it { should have_many :simple_grades }

    it { should belong_to :commute_method }
    it { should belong_to :user }
    it { should belong_to :scholarship_status }
    it { should belong_to :enrollment_status }

    it { should have_and_belong_to_many :guardians }

    it { should accept_nested_attributes_for(:guardians).allow_destroy(true) }

    it { should allow_mass_assignment_of :admitted }
    it { should allow_mass_assignment_of :graduated }
    it { should allow_mass_assignment_of :class_groups }
    it { should allow_mass_assignment_of :class_group_ids }
    it { should allow_mass_assignment_of :class_groups_attributes }
    it { should allow_mass_assignment_of :guardians }
    it { should allow_mass_assignment_of :guardians_attributes }
    it { should allow_mass_assignment_of :student_id_number }
    it { should allow_mass_assignment_of :student_foreign_id_number }
    it { should allow_mass_assignment_of :scholarship_status_id }
    it { should allow_mass_assignment_of :enrollment_status_id }
  end

  context 'methods' do

    context 'enrollment_status' do

    end
    xit 'scholarship'
    xit 'class_group_widget'
    xit 'seat_number_widget'
    xit 'address_widget'
    xit 'primary_address'
  end

end
