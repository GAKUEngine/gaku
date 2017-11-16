require 'spec_helper_models'

describe Gaku::Attachment do

  describe 'associations' do
    it { should belong_to :attachable }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_attachment_presence(:asset) }
    it { should have_attached_file :asset }
  end

  describe '#to_s' do
    let(:attachment) { build(:attachment) }
    specify { attachment.to_s.should eq attachment.name }
  end

end
