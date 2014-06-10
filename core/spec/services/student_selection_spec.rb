require 'spec_helper_models'

describe Gaku::StudentSelection do

  let(:student) { create(:student) }

  describe '.add' do
    it 'adds student to selection' do
      expect(described_class.add(student)).to eq([{ id: student.id.to_s, full_name: student.full_name}].as_json)
    end
  end

  describe '.remove' do
    it 'removes student from selection' do
      described_class.add(student)
      expect(described_class.remove(student)).to eq []
    end
  end

  describe '.all' do
    it 'returns all selected students' do
      described_class.add(student)
      expect(described_class.all).to eq([{ id: student.id.to_s, full_name: student.full_name}].as_json)
    end
  end

  describe '.remove_all' do
    it 'removes all selected students' do
      described_class.add(student)
      expect(described_class.remove_all).to eq []
    end
  end

end
