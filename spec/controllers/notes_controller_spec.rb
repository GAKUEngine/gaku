require 'spec_helper'

describe NotesController do
  let(:student) {Factory(:student)}
  before do
    login_admin
  end

  describe "GET :index	" do
    pending "should be successful" do
      get :index
      response.should be_success
    end
  end 

  describe "POST :create" do
    it "should create new note with ajax" do
      expect do
        post :create, :student_id => student.id, :note => {:title => "title NOTE", :content => "Content NOTE"}
      # change count "2" because Factory(:student) have after_create method for new note 
      end.to change(Note, :count).by(2)
    end
  end
end
