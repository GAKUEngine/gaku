require 'spec_helper'

describe Gaku::StudentGuardian do

  describe 'associations' do
    it { should belong_to :student }
    it { should belong_to :guardian }
  end

end
