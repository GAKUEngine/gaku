require 'spec_helper'

describe Gaku::UserRole do

  describe 'associations' do
    it { should belong_to :user }
    it { should belong_to :role }
  end

end
