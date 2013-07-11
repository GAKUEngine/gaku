require 'spec_helper'

describe Gaku::ClassGroup do

  describe 'concerns' do
    it_behaves_like 'notable'
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

    it 'is invalid without name' do
      build(:class_group, name: nil).should_not be_valid
    end
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
