require 'spec_helper_models'

describe Gaku::Course, type: :model do

  describe 'concerns' do
    it_behaves_like 'gradable'
    it_behaves_like 'enrollable'
    it_behaves_like 'semesterable'
  end

  describe 'associations' do

    it { should have_many :course_group_enrollments }
    it { should have_many(:course_groups).through(:course_group_enrollments) }

    it { should belong_to :syllabus }
    it { should belong_to :class_group }
    it { should have_many :exam_schedules }

    # it { should accept_nested_attributes_for :enrollments }
  end

  describe 'validations' do
    it { should validate_presence_of :code }
  end

  # context 'enroll_class_group' do
  #   it 'should enroll class group to course' do
  #     course = create(:course)
  #     student1, student2 = create(:student), create(:student, name: 'gaku')
  #     class_group = create(:class_group)
  #     create(:class_group_enrollment, student_id: student1.id, class_group_id: class_group.id)
  #     create(:class_group_enrollment, student_id: student2.id, class_group_id: class_group.id)
  #     course.enroll_class_group(class_group)
  #     course.student_ids.include?(student1.id)
  #     course.student_ids.include?(student2.id)
  #   end
  # end

  context 'counter_cache' do

    let!(:course) { create(:course) }

    context 'notes_count' do

      let(:note) { build(:note) }
      let(:course_with_note) { create(:course, :with_note) }

      it 'increments notes_count' do
        expect do
          course.notes << note
        end.to change { course.reload.notes_count }.by(1)
      end

      it 'decrements notes_count' do
        expect do
          course_with_note.notes.last.destroy
        end.to change { course_with_note.reload.notes_count }.by(-1)
      end
    end

    context 'enrollments_count' do

      let(:student) { build(:student) }
      let(:course_with_enrollment) { create(:course, :with_enrollment) }

      it 'increments enrollments_count' do
        expect do
          course.students << student
        end.to change { course.reload.enrollments_count }.by(1)
      end

      it 'decrements enrollments_count' do
        expect do
          course_with_enrollment.students.last.destroy
        end.to change { course_with_enrollment.reload.enrollments_count }.by(-1)
      end
    end

  end

end
