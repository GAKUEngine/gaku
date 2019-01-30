require 'spec_helper_models'

describe Gaku::Note, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to :notable }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_presence_of :content }
  end
end
