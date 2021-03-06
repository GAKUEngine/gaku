require 'spec_helper_models'

describe Gaku::ClassGroup, type: :model do
  describe 'concerns' do
    it_behaves_like 'notable'
    it_behaves_like 'enrollable'
    it_behaves_like 'semesterable'
    it_behaves_like 'student_reviewable'
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
  end

  describe '#to_s' do
    let(:class_group) { build(:class_group) }

    specify { class_group.to_s.should eq "#{class_group.grade} - #{class_group.name}" }
  end

  it '.active' do
    class_group = create(:class_group)
    active_semester = create(:active_semester)
    create(:semester_connector_class_group, semester: active_semester, semesterable: class_group)

    expect(described_class.active).to eq [class_group]
  end

  it '.upcomming' do
    class_group = create(:class_group)
    upcomming_semester = create(:upcomming_semester)
    create(:semester_connector_class_group, semester: upcomming_semester, semesterable: class_group)

    expect(described_class.upcomming).to eq [class_group]
  end

  it 'exclude from .upcomming if have active and not started semester' do
    class_group = create(:class_group)

    upcomming_semester = create(:upcomming_semester)
    create(:semester_connector_class_group, semester: upcomming_semester, semesterable: class_group)

    active_semester = create(:active_semester)
    create(:semester_connector_class_group, semester: active_semester, semesterable: class_group)

    expect(described_class.upcomming).not_to eq [class_group]
  end

  context 'counter_cache' do
    let!(:class_group) { create(:class_group) }

    context 'notes_count' do
      let(:note) { build(:note) }
      let(:class_group_with_note) { create(:class_group, :with_note) }

      it 'increments notes_count' do
        expect do
          class_group.notes << note
        end.to change { class_group.reload.notes_count }.by(1)
      end

      it 'decrements notes_count' do
        expect do
          class_group_with_note.notes.last.destroy
        end.to change { class_group_with_note.reload.notes_count }.by(-1)
      end
    end

    context 'enrollments_count' do
      let(:student) { build(:student) }
      let(:class_group_with_enrollment) { create(:class_group, :with_enrollment) }

      it 'increments enrollments_count' do
        expect do
          class_group.students << student
        end.to change { class_group.reload.enrollments_count }.by(1)
      end

      it 'decrements enrollments_count' do
        expect do
          class_group_with_enrollment.students.last.destroy
        end.to change { class_group_with_enrollment.reload.enrollments_count }.by(-1)
      end
    end
  end
end
