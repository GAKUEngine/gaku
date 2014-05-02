require 'spec_helper_models'

describe Gaku::Contact do

  describe 'associations' do
    it { should belong_to :contact_type }
    it { should belong_to :contactable }
  end

  describe 'validations' do
    it { should validate_presence_of :data }
    it { should validate_presence_of :contact_type }
  end

  describe 'instance methods' do
    it { should respond_to :name }
    it { should respond_to :primary? }
    it { should respond_to :make_primary }
  end

  describe 'class methods' do
    it('responds to .teachers') { expect(Gaku::Contact).to respond_to(:teachers) }
    it('responds to .students') { expect(Gaku::Contact).to respond_to(:students) }
    it('responds to .guardians') { expect(Gaku::Contact).to respond_to(:guardians) }
    it('responds to .primary_email') { expect(Gaku::Contact).to respond_to(:primary_email) }
    it('responds to .primary') { expect(Gaku::Contact).to respond_to(:primary) }
    it('responds to .secondary') { expect(Gaku::Contact).to respond_to(:secondary) }
  end

end
