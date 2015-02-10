require 'spec_helper_models'

describe Gaku::Enrollment do

  describe 'associations' do
    it { should belong_to :student }
    it { should belong_to :enrollmentable }
  end

  describe 'validations' do
    it { should validate_presence_of :student_id }
    it { should validate_presence_of :enrollmentable_id }
    it { should validate_presence_of :enrollmentable_type }

    it do
      should validate_uniqueness_of(:student_id).scoped_to([:enrollmentable_id, :enrollmentable_type])
                                                .with_message(/already enrolled/)
    end

    it('ensures inclusion') do
      should validate_inclusion_of(:enrollmentable_type)
        .in_array(%w(Gaku::Course Gaku::ClassGroup Gaku::ExtracurricularActivity))
    end
  end

  describe 'class_group_semesters_overlap validation' do
    it 'add message to base if semester overlapping' do
      student  = create(:student)
      semester = create(:active_semester)

      class_group  = create(:class_group_with_active_semester, semester: semester)
      class_group2 = create(:class_group_with_active_semester, semester: semester)

      create(:class_group_enrollment, enrollmentable: class_group, student: student)

      enrollment = build(:class_group_enrollment, enrollmentable: class_group2, student: student)

      enrollment.valid?

      expect(enrollment.errors[:base]).to include 'A student cannot belong to two Class Groups with overlapping semesters'
    end
  end

end
