require 'spec_helper_models'

describe Gaku::Student do

  describe 'concerns' do
    it_behaves_like 'thrashable'
  end

  describe 'versioning' do
    it { should be_versioned }
  end

end
