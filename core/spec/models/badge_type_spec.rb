require 'spec_helper_models'

describe Gaku::BadgeType, type: :model do
  describe 'relations' do
    it { is_expected.to have_many :badges }
    it { is_expected.to have_many(:students).through(:badges) }
  end

  describe 'validations' do
    it { is_expected.to have_attached_file :badge_image }
    it { is_expected.to validate_presence_of :name }
  end

  describe '#to_s' do
    let(:badge_type) { build(:badge_type) }

    specify { badge_type.to_s.should eq badge_type.name }
  end
end
