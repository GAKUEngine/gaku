require 'spec_helper_models'

describe Gaku::GradingMethods::Score do

  let(:students) { [create(:student), create(:student)] }

  describe 'initialize' do
    it 'initializes with exam' do
      exam =  create(:exam, :with_portion)
      subject = described_class.new(exam, students)
      expect(subject.grade).to eq({ exam_id: exam.id,
                                    student_results: [
                                                       { id: students[0].id, score: 0.0 },
                                                       { id: students[1].id, score: 0.0 }
                                                     ]
                                  }.as_json
                                 )

    end
  end

end
