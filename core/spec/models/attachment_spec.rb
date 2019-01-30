require 'spec_helper_models'

describe Gaku::Attachment, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to :attachable }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_attachment_presence(:asset) }
    it { is_expected.to have_attached_file :asset }
  end

  describe '#to_s' do
    let(:attachment) { build(:attachment) }

    specify { attachment.to_s.should eq attachment.name }
  end
end
