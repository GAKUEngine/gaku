require 'spec_helper_models'

describe Gaku::Grading::Collection::Result do
  subject { described_class.new(1, {id: 2, score: 33}) }

  describe '.initialize' do
    it 'initializes result hash' do
      expect(subject.as_json).to eq({ exam_id: 1, student_results: { id: 2, score: 33 } }.as_json)
    end
  end


end
