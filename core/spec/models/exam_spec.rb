require 'spec_helper_models'

describe Gaku::Exam, type: :model do

  let!(:exam) { create(:exam) }

  describe 'concerns' do
    it_behaves_like 'notable'
    it_behaves_like 'gradable'
  end

  describe 'associations' do
    it { should have_many :exam_portions }
    it { should have_many(:exam_portion_scores).through(:exam_portions) }

    it { should have_many :exam_syllabuses }
    it { should have_many(:syllabuses).through(:exam_syllabuses) }

    it { should have_many :attendances }
    it { should have_many :exam_scores }
    it { should belong_to :grading_method }
    it { should belong_to :department }

    it { should have_many :exam_sessions }

    it { should accept_nested_attributes_for :exam_portions }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_numericality_of :weight }

    it 'errors when name is nil' do
      exam.name = nil
      exam.should_not be_valid
    end

    it 'should validate weight is greater than 0' do
      exam.weight = -1
      exam.should be_invalid
    end

    it 'should validate weight is 0' do
      exam.weight = 0
      exam.should be_valid
    end
  end

  context 'counter_cache' do

    context 'exam_portions_count' do
      let(:exam_portion) { build(:exam_portion) }
      let(:exam_with_portions) { create(:exam, :with_portions) }

      it 'increments exam_portions_count' do
        expect do
          exam.exam_portions << exam_portion
        end.to change { exam.reload.exam_portions_count }.by(1)
      end

      it 'decrements exam_portions_count' do
        expect do
          exam_with_portions.exam_portions.last.destroy
        end.to change { exam_with_portions.reload.exam_portions_count }.by(-1)
      end
    end

    context 'notes_count' do

      let(:note) { build(:note) }
      let(:exam_with_note) { create(:exam, :with_note) }

      it 'increments notes_count' do
        expect do
          exam.notes << note
        end.to change { exam.reload.notes_count }.by(1)
      end

      it 'decrements notes_count' do
        expect do
          exam_with_note.notes.last.destroy
        end.to change { exam_with_note.reload.notes_count }.by(-1)
      end
    end
  end

  context '#max_score' do
    let(:exam_with_portions) { create(:exam, :with_portions) }
    it 'sums' do
      expect(exam_with_portions.max_score).to eq 300
    end
  end

  context 'methods' do
    xit 'total_weight'
    xit 'max_score'
  end

end
