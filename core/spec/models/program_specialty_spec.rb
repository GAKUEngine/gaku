require 'spec_helper'

describe Gaku::ProgramSpecialty do

  describe 'associations' do
    it { should belong_to :program }
    it { should belong_to :specialty }
  end

  describe 'validations' do
    it { should validate_presence_of :specialty }
    it { should validate_presence_of :program }
  end

end
