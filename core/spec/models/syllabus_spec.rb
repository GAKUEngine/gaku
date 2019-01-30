require 'spec_helper_models'

describe Gaku::Syllabus, type: :model do
  describe 'concerns' do
    it_behaves_like 'notable'
  end

  describe 'associations' do
    it { is_expected.to have_many :courses }
    it { is_expected.to have_many :assignments }
    it { is_expected.to have_many :lesson_plans }
    it { is_expected.to have_many :notes }
    it { is_expected.to have_many :programs }

    it { is_expected.to have_many :exam_syllabuses }
    it { is_expected.to have_many(:exams).through(:exam_syllabuses) }

    it { is_expected.to accept_nested_attributes_for :exams }
    it { is_expected.to accept_nested_attributes_for :assignments }

    it { is_expected.to belong_to :department }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :code }
  end

  context 'counter_cache' do
    let!(:syllabus) { create(:syllabus) }

    context 'notes_count' do
      let(:note) { build(:note) }
      let(:syllabus_with_note) { create(:syllabus, :with_note) }

      it 'increments notes_count' do
        expect do
          syllabus.notes << note
        end.to change { syllabus.reload.notes_count }.by(1)
      end

      it 'decrements notes_count' do
        expect do
          syllabus_with_note.notes.last.destroy
        end.to change { syllabus_with_note.reload.notes_count }.by(-1)
      end
    end

    context 'exams_count' do
      let(:exam) { create(:exam) }
      let(:syllabus_with_exam) { create(:syllabus, :with_exam) }

      it 'increments exams_count' do
        expect do
          syllabus.exams << exam
        end.to change { syllabus.reload.exams_count }.by(1)
      end

      it 'decrements exams_count' do
        expect do
          syllabus_with_exam.exams.last.destroy
        end.to change { syllabus_with_exam.reload.exams_count }.by(-1)
      end
    end
  end
end
