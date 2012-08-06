require 'spec_helper'

describe ContactsController do

  let(:contact) { FactoryGirl.build_stubbed(:contact) }
  let(:student) { Factory(:student)}
  let(:guardian) { Factory(:guardian)}
  let(:contact_type){Factory(:contact_type)}
  
  before do
    login_admin
  end

  describe "POST :create" do
    it "should create new contact for guardian" do
      expect do
        xhr :post, :create, :student_id => student.id, :guardian_id => guardian.id, 
                                                        :contact => {:contact_type_id => contact_type.id,
                                                                     :data => 'guardian@gakuengine.com',
                                                                     :details =>'Office eMail' } 
      end.to change(Contact, :count).by(1)
     end
  end 
  
end
