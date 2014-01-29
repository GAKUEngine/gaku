require 'spec_helper_models'

describe Gaku::ContactType do

  describe 'relations' do
    it { should have_many :contacts }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }
  end

  describe '#to_s' do
    let(:contact_type) { build(:contact_type) }
    specify { contact_type.to_s.should eq contact_type.name }
  end

end
