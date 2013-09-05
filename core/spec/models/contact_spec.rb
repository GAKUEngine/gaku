require 'spec_helper'

describe Gaku::Contact do

  describe 'associations' do
    it { should belong_to :contact_type }
    it { should belong_to :contactable }
  end

  describe 'validations' do
    it { should validate_presence_of :data }
    it { should validate_presence_of :contact_type }
  end

  describe 'versioning' do
    it { should be_versioned }
  end


  describe 'methods' do
    it { should respond_to :name }
    it { should respond_to :primary? }
    it { should respond_to :make_primary }
    xit 'ensure_first_is_primary'
    xit 'remove_other_primary'
  end

end
