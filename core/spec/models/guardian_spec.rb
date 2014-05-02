require 'spec_helper_models'

describe Gaku::Guardian do

  describe 'concerns' do
    it_behaves_like 'person'
    it_behaves_like 'addressable'
    it_behaves_like 'contactable'
    it_behaves_like 'avatarable'
  end

  describe 'relations' do
    it { should belong_to :user }
    it { should have_many :student_guardians }
    it { should have_many(:students).through(:student_guardians) }
  end

  describe '#primary_contact' do
    it('responds to primary_contact') { should respond_to(:primary_contact) }
  end

  describe '#primary_address' do
    it('responds to primary_address') { should respond_to(:primary_address) }
  end

  context 'counter_cache' do
    let!(:guardian) { create(:guardian) }

    context 'addresses_count' do

      let(:address) { build(:address) }
      let(:guardian_with_address) { create(:guardian, :with_address) }

      it 'increments addresses_count' do
        expect do
          guardian.addresses << address
        end.to change { guardian.reload.addresses_count }.by 1
      end

      it 'decrements addresses_count' do
        expect do
          guardian_with_address.addresses.last.destroy
        end.to change { guardian_with_address.reload.addresses_count }.by -1
      end
    end

    context 'contacts_count' do

      let(:contact) { build(:contact) }
      let(:guardian_with_contact) { create(:guardian, :with_contact) }

      it 'increments contacts_count' do
        expect do
          guardian.contacts << contact
        end.to change { guardian.reload.contacts_count }.by 1
      end

      it 'decrements contacts_count' do
        expect do
          guardian_with_contact.contacts.last.destroy
        end.to change { guardian_with_contact.reload.contacts_count }.by -1
      end
    end
  end



end
