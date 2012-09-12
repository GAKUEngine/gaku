require 'spec_helper'

describe Contact do

	let(:student) {Factory(:student)}

  context "validations" do 
  	it { should have_valid_factory(:contact) }
    it { should belong_to(:contact_type) }
    it { should belong_to(:student) }
    it { should belong_to(:guardian) }
  end
  

  context 'make first student contact primary on create' do
  	it "should first student address be primary" do
  		contact = FactoryGirl.build(:contact, :student_id => student.id)
  		contact.save
  	  contact.should be_is_primary
  	end

  	it "should next student address not be primary on create" do
  		contact = Factory.create(:contact, :student_id => student.id)
  	  contact2 = FactoryGirl.build(:contact, :student_id => student.id)
  	  contact2.save
  	  contact2.should_not be_is_primary 
  	end
  end

  context 'make contact primary' do
    it "should make contact for student primary" do
      contact = Factory.create(:contact, :student_id => student.id)
      contact2 = Factory.create(:contact, :student_id => student.id)
      contact2.make_primary_student
      contact2.should be_is_primary
    end

    it "should make other contacts for students not primary" do
      contact1  = Factory.create(:contact, :student_id => student.id)
      contact2 = Factory.create(:contact, :student_id => student.id)
      contact2.make_primary_student
      # get again refreshed contact1 from database
      contact1_db = Contact.find(contact1.id)
      contact1_db.should_not be_is_primary
    end
  end

end
