require 'spec_helper_models'

describe Gaku::GradingMethods::Result do
  subject { described_class.new(1) }

  describe '.initialize' do
    it 'initializes result hash' do
      expect(subject.result).to eq({exam_id: 1, student_results: []})
    end
  end

  describe '#append_score' do
    it 'appends student score' do
      expect(subject.append_score(2, 0.1)).to eq [{ id: 2, score: 0.1 }]
    end
  end

  describe '#as_json' do
    it 'returns result json' do
      subject.append_score(2, 0.1)
      expect(subject.as_json).to eq({exam_id: 1, student_results: [{ id: 2, score: 0.1 }]}.as_json)
    end
  end

end
