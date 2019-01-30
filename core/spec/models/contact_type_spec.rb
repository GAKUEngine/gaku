require 'spec_helper_models'

describe Gaku::ContactType, type: :model do
  describe 'relations' do
    it { is_expected.to have_many :contacts }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_uniqueness_of :name }
  end

  describe '#to_s' do
    let(:contact_type) { build(:contact_type) }

    specify { contact_type.to_s.should eq contact_type.name }
  end
end
