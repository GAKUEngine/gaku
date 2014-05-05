require 'spec_helper_models'

describe Gaku::GradingMethodConnector do

  describe 'associations' do
    it { should belong_to :gradable }
    it { should belong_to :grading_method }
  end

  describe 'validations' do
    it { should validate_presence_of :grading_method_id }
    it { should validate_presence_of :gradable_id }
    it { should validate_presence_of :gradable_type }
    it { should ensure_inclusion_of(:gradable_type).in_array(%w(Gaku::Exam Gaku::Course)) }
    it { should validate_uniqueness_of(:grading_method_id).scoped_to([:gradable_type, :gradable_id]) }

  end

end
