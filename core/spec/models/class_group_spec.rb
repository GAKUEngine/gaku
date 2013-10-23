require 'spec_helper'

describe Gaku::ClassGroup do

  describe 'concerns' do
    it_behaves_like 'notable'
    it_behaves_like 'thrashable'
  end

  describe 'associations' do
    it { should have_many :enrollments }
    it { should have_many(:students).through(:enrollments) }
    it { should have_many(:class_group_course_enrollments).dependent(:destroy) }
    it { should have_many(:courses).through(:class_group_course_enrollments) }
    it { should have_many(:semester_class_groups).dependent(:destroy) }
    it { should have_many(:semesters).through(:semester_class_groups) }
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
        end.to change { class_group.reload.notes_count }.by 1
      end

      it 'decrements notes_count' do
        expect do
          class_group_with_note.notes.last.destroy
        end.to change { class_group_with_note.reload.notes_count }.by -1
      end
    end
  end

end
