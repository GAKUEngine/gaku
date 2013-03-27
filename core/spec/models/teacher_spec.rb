require 'spec_helper'

describe Gaku::Teacher do

  context "validations" do

    it_behaves_like 'person'
    it_behaves_like 'addressable'
    it_behaves_like 'notable'
    it_behaves_like 'contactable'
    it_behaves_like 'avatarable'
    it_behaves_like 'thrashable'

    it { should belong_to :user }

  end

  context 'counter_cache' do

    let!(:teacher) { FactoryGirl.create(:teacher) }

    context 'addresses_count' do

      let(:address) { build(:address) }
      let(:teacher_with_address) { create(:teacher, :with_address) }

      it "increments addresses_count" do
        expect do
          teacher.addresses << address
        end.to change { teacher.reload.addresses_count }.by 1
      end

      it "decrements addresses_count" do
        expect do
          teacher_with_address.addresses.last.destroy
        end.to change { teacher_with_address.reload.addresses_count }.by -1
      end
    end

    context 'contacts_count' do

      let(:contact) { build(:contact) }
      let(:teacher_with_contact) { create(:teacher, :with_contact) }

      it "increments contacts_count" do
        expect do
          teacher.contacts << contact
        end.to change { teacher.reload.contacts_count }.by 1
      end

      it "decrements contacts_count" do
        expect do
          teacher_with_contact.contacts.last.destroy
        end.to change { teacher_with_contact.reload.contacts_count }.by -1
      end
    end


    context 'notes_count' do

      let(:note) { build(:note) }
      let(:teacher_with_note) { create(:teacher, :with_note) }

      it "increments notes_count" do
        expect do
          teacher.notes << note
        end.to change { teacher.reload.notes_count }.by 1
      end

      it "decrements notes_count" do
        expect do
          teacher_with_note.notes.last.destroy
        end.to change { teacher_with_note.reload.notes_count }.by -1
      end
    end


  end

end
