require 'spec_helper_models'

describe Gaku::ClassGroup do

  describe 'concerns' do
    it_behaves_like 'notable'
    it_behaves_like 'enrollmentable'
    it_behaves_like 'semesterable'
  end

  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe '#to_s' do
    let(:class_group) { build(:class_group) }
    specify { class_group.to_s.should eq "#{class_group.grade} - #{class_group.name}" }
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
