require 'spec_helper_models'

describe Gaku::ProgramLevel, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to :program }
    it { is_expected.to belong_to :level }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :level }
    # it { should validate_presence_of :program }
  end
end
