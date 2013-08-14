require 'spec_helper'

describe Gaku::ContactType do

  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe '#to_s' do
    let(:contact_type) { build(:contact_type) }
    specify { contact_type.to_s.should eq contact_type.name }
  end

end
