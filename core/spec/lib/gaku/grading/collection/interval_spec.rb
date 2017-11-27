require 'spec_helper_models'

describe Gaku::Grading::Collection::Interval do

  let(:student1) { create(:student) }
  let(:student2) { create(:student) }
  let(:student3) { create(:student) }
  let(:course) { create(:course) }
  let(:exam) { create(:exam) }
  let(:exam_portion1) { create(:exam_portion, exam: exam) }
  let(:exam_portion2) { create(:exam_portion, exam: exam) }

  let(:grading_method) do
    create(:grading_method, name: 'Interval', grading_type: 'interval',
      criteria: { Top: '50', Bottom: '50' }.as_json)
  end

  describe 'caluclates' do
    it 'interval  from exam portion scores' do
      create(:exam_portion_score, score: 28,  student:student1, exam_portion: exam_portion1, gradable: course)
      create(:exam_portion_score, score: 45,  student:student1, exam_portion: exam_portion2, gradable: course)

      create(:exam_portion_score, score: 68,  student:student2, exam_portion: exam_portion1, gradable: course)
      create(:exam_portion_score, score: 100, student:student2, exam_portion: exam_portion2, gradable: course)

      subject = described_class.new(exam, [student1, student2], course, grading_method.criteria)

      expect(subject.grade_exam).to eq [{id: student2.id, score: 'Top'}, {id: student1.id, score: 'Bottom'}]

    end

    it 'students with same score get same interval criteria' do
      create(:exam_portion_score, score: 50,  student:student1, exam_portion: exam_portion1, gradable: course)
      create(:exam_portion_score, score: 50,  student:student1, exam_portion: exam_portion2, gradable: course)

      create(:exam_portion_score, score: 50,  student:student2, exam_portion: exam_portion1, gradable: course)
      create(:exam_portion_score, score: 50, student:student2, exam_portion: exam_portion2, gradable: course)

      create(:exam_portion_score, score: 40,  student:student3, exam_portion: exam_portion1, gradable: course)
      create(:exam_portion_score, score: 40, student:student3, exam_portion: exam_portion2, gradable: course)
      subject = described_class.new(exam, [student1, student2, student3], course, grading_method.criteria)

      expect(subject.grade_exam).to eq [{id: student1.id, score: 'Top'}, {id: student2.id, score: 'Top'}, {id: student3.id, score: 'Bottom'}]

    end
  end

end
