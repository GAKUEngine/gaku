require 'spec_helper_models'

describe Gaku::Grading::Collection::Calculations do

  let(:student1) { create(:student) }
  let(:student2) { create(:student) }
  let(:exam) { create(:exam) }
  let(:course) { create(:course) }
  let(:exam_portion1) { create(:exam_portion, exam: exam) }
  let(:exam_portion2) { create(:exam_portion, exam: exam) }

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

  it 'calculate grading methods from exam portion scores' do
    create(:exam_portion_score, score: 80,  student:student1, exam_portion: exam_portion1, gradable: course)
    create(:exam_portion_score, score: 65,  student:student1, exam_portion: exam_portion2, gradable: course)
    create(:exam_portion_score, score: 68,  student:student2, exam_portion: exam_portion1, gradable: course)
    create(:exam_portion_score, score: 100, student:student2, exam_portion: exam_portion2, gradable: course)

    subject = described_class.new([grading_method1, grading_method2, grading_method3, grading_method4], [student1, student2], exam, course)

    expect(subject.calculate).to eq({
      grading_method1.id => {exam_id: exam.id, student_results: [{id: student1.id, score: 145.0}, {id: student2.id, score: 168.0}]}.as_json,
      grading_method2.id => {exam_id: exam.id, student_results: [{id: student1.id, score: 72.5}, {id: student2.id, score: 84.0}]}.as_json,
      grading_method3.id => {exam_id: exam.id, student_results: [{id: student1.id, score: 'C'}, {id: student2.id, score: 'B'}]}.as_json,
      grading_method4.id => {exam_id: exam.id, student_results: [{id: student2.id, score: 'Top'}, {id: student1.id, score: 'Bottom'}]}.as_json
    })
  end

end
