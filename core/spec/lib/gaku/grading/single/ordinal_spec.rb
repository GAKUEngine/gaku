require 'spec_helper_models'

describe Gaku::Grading::Single::Ordinal do

  let(:student) { create(:student) }
  let(:exam) { create(:exam) }
  let(:course) { create(:course) }

  let(:exam_portion1) { create(:exam_portion, exam: exam) }
  let(:exam_portion2) { create(:exam_portion, exam: exam) }
  let(:exam_portion_score1) do
    create(:exam_portion_score, score: 28, student:student, exam_portion: exam_portion1, gradable: course)
  end
  let(:exam_portion_score2) do
    create(:exam_portion_score, score: 35, student:student, exam_portion: exam_portion2, gradable: course)
  end

  let(:grading_method) do
    create(:grading_method, name: 'Ordinal', grading_type: 'ordinal',
      criteria: { A: '90', B:'80', C: '60', D: '40', F: '10' }.as_json)
  end

  subject { described_class.new(exam, student, course, grading_method.criteria) }

  describe 'initialize' do
    it 'initializes with exam' do
      expect(subject.grade_exam).to eq({ id: student.id, score: nil })
    end
  end

  describe 'with exam portion scores' do
    before do
      exam
      exam_portion1;exam_portion2
    end
    it "doesn't create exam_portion_score if exists" do
      exam_portion_score1; exam_portion_score2
      expect do
        subject.grade_exam
      end.to_not change(student.reload.exam_portion_scores, :count)
    end

    it 'calculates grade A from exam_portion_scores' do
      create(:exam_portion_score, score: 90, student:student, exam_portion: exam_portion1, gradable: course)
      create(:exam_portion_score, score: 90, student:student, exam_portion: exam_portion2, gradable: course)

      expect(subject.grade_exam).to eq({ id: student.id, score: 'A' })
    end

    it 'calculates grade B from exam_portion_scores' do
      create(:exam_portion_score, score: 80, student:student, exam_portion: exam_portion1, gradable: course)
      create(:exam_portion_score, score: 80, student:student, exam_portion: exam_portion2, gradable: course)

      expect(subject.grade_exam).to eq({ id: student.id, score: 'B' })
    end

    it 'calculates grade C from exam_portion_scores' do
      create(:exam_portion_score, score: 60, student:student, exam_portion: exam_portion1, gradable: course)
      create(:exam_portion_score, score: 60, student:student, exam_portion: exam_portion2, gradable: course)

      expect(subject.grade_exam).to eq({ id: student.id, score: 'C' })
    end

    it 'calculates grade D from exam_portion_scores' do
      create(:exam_portion_score, score: 40, student:student, exam_portion: exam_portion1, gradable: course)
      create(:exam_portion_score, score: 40, student:student, exam_portion: exam_portion2, gradable: course)

      expect(subject.grade_exam).to eq({ id: student.id, score: 'D' })
    end

    it 'calculates grade F from exam_portion_scores' do
      create(:exam_portion_score, score: 10, student:student, exam_portion: exam_portion1, gradable: course)
      create(:exam_portion_score, score: 15, student:student, exam_portion: exam_portion2, gradable: course)

      expect(subject.grade_exam).to eq({ id: student.id, score: 'F' })
    end

    it 'didnt show grade if percentage is bellow last criteria' do
      create(:exam_portion_score, score: 1, student:student, exam_portion: exam_portion1, gradable: course)
      create(:exam_portion_score, score: 1, student:student, exam_portion: exam_portion2, gradable: course)

      expect(subject.grade_exam).to eq({ id: student.id, score: '' })
    end
  end

end
