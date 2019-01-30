require 'spec_helper_models'

describe Gaku::Contact, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to :contact_type }
    it { is_expected.to belong_to :contactable }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :data }
    it { is_expected.to validate_presence_of :contact_type }
  end

  describe 'instance methods' do
    it { is_expected.to respond_to :name }
    it { is_expected.to respond_to :primary? }
    it { is_expected.to respond_to :make_primary }
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
