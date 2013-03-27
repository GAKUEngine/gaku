require 'spec_helper'

describe Gaku::Guardian do

  context "validations" do
  	let(:guardian) { stub_model(Gaku::Guardian) }

    it_behaves_like 'person'
    it_behaves_like 'addressable'
    it_behaves_like 'contactable'
    it_behaves_like 'avatarable'

    it { should belong_to :user }
    it { should have_many :student_guardians }
    it { should have_many(:students).through(:student_guardians) }

    it { should allow_mass_assignment_of :relationship }
  end

  context 'counter_cache' do

    let!(:guardian) { FactoryGirl.create(:guardian) }


    context 'addresses_count' do

      let(:address) { build(:address) }
      let(:guardian_with_address) { create(:guardian, :with_one_address) }

      it "increments addresses_count" do
        expect do
          guardian.addresses << address
        end.to change { guardian.reload.addresses_count }.by 1
      end

      it "decrements addresses_count" do
        expect do
          guardian_with_address.addresses.last.destroy
        end.to change { guardian_with_address.reload.addresses_count }.by -1
      end
    end

    context 'contacts_count' do

      let(:contact) { build(:contact) }
      let(:guardian_with_contact) { create(:guardian, :with_one_contact) }

      it "increments contacts_count" do
        expect do
          guardian.contacts << contact
        end.to change { guardian.reload.contacts_count }.by 1
      end

      it "decrements contacts_count" do
        expect do
          guardian_with_contact.contacts.last.destroy
        end.to change { guardian_with_contact.reload.contacts_count }.by -1
      end
    end


  end

  context 'methods' do
    xit 'primary_contact'
    xit 'primary_address'
  end

end
