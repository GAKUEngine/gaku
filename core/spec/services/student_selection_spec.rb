require 'spec_helper_models'

describe Gaku::StudentSelection do
  let(:student) { create(:student) }
  let(:student2) { create(:student) }
  let!(:user) { create(:user) }

  before do
    $redis.del(:student_selection)
  end

  describe '.add' do
    it 'adds student to selection' do
      expect(described_class.new(user).add(student)).to eq([student])
    end
  end

  describe '.remove' do
    it 'removes student from selection' do
      described_class.new(user).add(student)
      expect(described_class.new(user).remove(student)).to eq []
    end
  end

  describe '.all' do
    it 'returns all selected students' do
      described_class.new(user).add(student)
      expect(described_class.new(user).all).to eq([student.id.to_s])
    end
  end

  describe '.students' do
    it 'returns students object selected students' do
      described_class.new(user).add(student)
      expect(described_class.new(user).students).to eq([student])
    end
  end

  describe '.remove_all' do
    it 'removes all selected students' do
      described_class.new(user).add(student)
      expect(described_class.new(user).remove_all).to eq []
    end
  end

  describe '.collection' do
    it 'add collection to selected students' do
      described_class.new(user).collection([student, student2])
      expect(described_class.new(user).all).to eq [student.id.to_s, student2.id.to_s]
      expect(described_class.new(user).students).to eq [student, student2]
    end
  end

  describe '.remove_collection' do
    it 'add collection to selected students' do
      described_class.new(user).collection([student, student2])
      described_class.new(user).remove_collection([student, student2])
      expect(described_class.new(user).all).to eq []
      expect(described_class.new(user).students).to eq []
    end
  end
end
