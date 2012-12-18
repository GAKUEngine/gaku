require 'spec_helper'

describe Gaku::Contact do

	let(:student) { create(:student) }

  context "validations" do 
    it { should belong_to(:contact_type) }
    it { should belong_to(:student) }
    it { should belong_to(:guardian) }
    it { should belong_to(:campus) }

    it { should validate_presence_of(:data) }
    it { should validate_presence_of(:contact_type_id) }
  end

  context 'make first student contact primary on create' do
  	it "should first student address be primary" do
  		contact = build(:contact, :student_id => student.id)
  		contact.save
  	  contact.should be_is_primary
  	end

  	it "should next student address not be primary on create" do
  		contact = create(:contact, :student_id => student.id)
  	  contact2 = build(:contact, :student_id => student.id)
  	  contact2.save
  	  contact2.should_not be_is_primary 
  	end
  end

  context 'make contact primary' do
    it "should make contact for student primary" do
      contact = create(:contact, :student_id => student.id)
      contact2 = create(:contact, :student_id => student.id)
      contact2.make_primary_student
      contact2.should be_is_primary
    end

    it "should make other contacts for students not primary" do
      contact1  = create(:contact, :student_id => student.id)
      contact2 = create(:contact, :student_id => student.id)
      contact2.make_primary_student
      # get again refreshed contact1 from database
      contact1_db = Gaku::Contact.find(contact1.id)
      contact1_db.should_not be_is_primary
    end
  end

end
