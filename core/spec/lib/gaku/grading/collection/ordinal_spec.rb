require 'spec_helper_models'

describe Gaku::Grading::Collection::Ordinal do

  let(:student1) { create(:student) }
  let(:student2) { create(:student) }
  let(:exam) { create(:exam) }
  let(:course) { create(:course) }

  let(:exam_portion1) { create(:exam_portion, exam: exam) }
  let(:exam_portion2) { create(:exam_portion, exam: exam) }

  let(:grading_method) do
    create(:grading_method, name: 'Ordinal', grading_type: 'ordinal',
      criteria: { A: '90', B:'80', C: '60', D: '40', F: '10' }.as_json)
  end

  it 'calculates ordinal from exam portion scores' do
    create(:exam_portion_score, score: 28,  student:student1, exam_portion: exam_portion1, gradable: course)
    create(:exam_portion_score, score: 45,  student:student1, exam_portion: exam_portion2, gradable: course)
    create(:exam_portion_score, score: 68,  student:student2, exam_portion: exam_portion1, gradable: course)
    create(:exam_portion_score, score: 100, student:student2, exam_portion: exam_portion2, gradable: course)

    subject = described_class.new(exam, [student1, student2], course, grading_method.criteria)

    expect(subject.grade_exam).to eq [{id: student1.id, score: 'F'}, {id: student2.id, score: 'B'}]

  end

end
