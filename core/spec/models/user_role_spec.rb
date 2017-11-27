require 'spec_helper_models'

describe Gaku::UserRole, type: :model do

  describe 'associations' do
    it { should belong_to :user }
    it { should belong_to :role }
  end

end
