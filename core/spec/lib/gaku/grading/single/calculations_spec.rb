require 'spec_helper_models'

describe Gaku::Grading::Single::Calculations do

  let(:student) { create(:student) }
  let(:student2) { create(:student) }
  let(:exam) { create(:exam) }
  let(:course) { create(:course) }
  let(:exam_portion1) { create(:exam_portion, exam: exam) }
  let(:exam_portion2) { create(:exam_portion, exam: exam) }
  let(:exam_portion_score1) do
    create(:exam_portion_score, score: 80, student: student, exam_portion: exam_portion1, gradable: course)
  end
  let(:exam_portion_score2) do
    create(:exam_portion_score, score: 65, student: student, exam_portion: exam_portion2, gradable: course)
  end

  let(:exam_portion_score3) do
    create(:exam_portion_score, score: 50, student: student2, exam_portion: exam_portion1, gradable: course)
  end
  let(:exam_portion_score4) do
    create(:exam_portion_score, score: 50, student: student2, exam_portion: exam_portion2, gradable: course)
  end

  let(:grading_method1) { create(:grading_method, grading_type: 'score')}
  let(:grading_method2) { create(:grading_method, grading_type: 'percentage')}
  let(:grading_method3) do
    create(:grading_method, grading_type: 'ordinal',
      criteria: { A: '90', B:'80', C: '60', D: '40', F: '10' }.as_json)
  end



  let(:grading_method4) do
    create(:grading_method, grading_type: 'interval',
      criteria: { Top: '50',  Bottom: '50' }.as_json)
  end

  subject { described_class.new([grading_method1, grading_method2, grading_method3, grading_method4], student, exam, course, [student, student2] ) }

  describe 'initialize' do
    it 'initializes with exam' do
      expect(subject.calculate).to eq({
        grading_method1.id => {id: student.id, score: nil, exam_id: exam.id}.as_json,
        grading_method2.id => {id: student.id, score: nil, exam_id: exam.id}.as_json,
        grading_method3.id => {id: student.id, score: nil, exam_id: exam.id}.as_json,
        grading_method4.id => {exam_id: exam.id, student_results: [{id: student.id, score: nil}, {id: student2.id, score: nil}]}.as_json

      })
    end
  end

  describe 'with exam portion scores' do

    before do
      exam
      exam_portion1; exam_portion2
      exam_portion_score1; exam_portion_score2; exam_portion_score3; exam_portion_score4;
    end

    it "doesn't create exam_portion_score if exists" do
      expect do
        subject.calculate
      end.to_not change(student.reload.exam_portion_scores, :count)
    end

    it 'calculates scores from exam_portion_scores' do
      expect(subject.calculate).to eq({
        grading_method1.id => {id: student.id, score:145.0, exam_id: exam.id}.as_json,
        grading_method2.id => {id: student.id, score:72.5, exam_id: exam.id}.as_json,
        grading_method3.id => {id: student.id, score:'C', exam_id: exam.id}.as_json,
        grading_method4.id => {exam_id: exam.id, student_results: [{id: student.id, score: 'Top'}, {id: student2.id, score: 'Bottom'}]}.as_json
      })
    end
  end

end
