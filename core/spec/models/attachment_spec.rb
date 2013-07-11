require 'spec_helper'

describe Gaku::Attachment do

  describe 'associations' do
    it { should belong_to :attachable }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should have_attached_file :asset }
  end

end
