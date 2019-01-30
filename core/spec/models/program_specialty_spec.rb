require 'spec_helper_models'

describe Gaku::ProgramSpecialty, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to :program }
    it { is_expected.to belong_to :specialty }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :specialty }
    # it { should validate_presence_of :program }
  end
end
