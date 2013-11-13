require 'spec_helper_models'

describe Gaku::Note do

  describe 'associations' do
    it { should belong_to :notable }
  end

  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :content }
  end

end
