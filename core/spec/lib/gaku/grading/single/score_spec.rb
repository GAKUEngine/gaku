require 'spec_helper_models'

describe Gaku::Grading::Single::Score do

  let(:student) { create(:student) }
  let(:exam) { create(:exam, :with_portions) }

  subject { described_class.new(exam, student) }

  describe 'initialize' do
    it 'initializes with exam' do
      expect(subject.grade_exam).to eq({ id: student.id, score: nil })
    end
  end

  describe 'exam_portion_scores' do
    it 'creates exam_portion_score if not exist' do
      expect do
        subject.grade_exam
      end.to change(student.reload.exam_portion_scores, :count).by(2)
    end

    it "doesn't create exam_portion_score if exists" do
      create(:exam_portion_score, student: student, exam_portion: exam.exam_portions.first)
      create(:exam_portion_score, student: student, exam_portion: exam.exam_portions.last)

      expect do
        subject.grade_exam
      end.to_not change(student.reload.exam_portion_scores, :count)
    end

    xit 'calculates scores from exam_portion_scores' do
      create(:exam_portion_score, score: 5, student: student, exam_portion: exam.exam_portions.first)
      create(:exam_portion_score, score: 10, student: student, exam_portion: exam.exam_portions.last)

      expect(subject.grade_exam).to eq({ id: student.id, score: 100.0 })
    end
  end

end
