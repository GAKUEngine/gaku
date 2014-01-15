require 'spec_helper_models'

describe Gaku::BadgeType do

  describe 'relations' do
    it { should have_many :badges }
    it { should have_many(:students).through(:badges) }
  end

  describe 'validations' do
    it { should have_attached_file :badge_image }
    it { should validate_presence_of :name }
  end

  describe '#to_s' do
    let(:badge_type) { build(:badge_type) }
    specify { badge_type.to_s.should eq badge_type.name }
  end

end
