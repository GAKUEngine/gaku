require 'spec_helper'

describe SyllabusesController do

  let!(:syllabus) { FactoryGirl.build_stubbed(:syllabus) }

  before do
    login_admin
  end

  it "should have a current_user" do
    subject.current_user.should_not be_nil
  end

  describe "GET :index	" do
    it "should be successful" do
      get :index
      response.should be_success
    end
  end 

  describe "POST create" do
    it "redirects to the new syllabus" do
      page.stub :save => true

      post :create
      response.should redirect_to(syllabus_url(Syllabus.last))
    end
  end
end