require 'spec_helper'

describe Gaku::SyllabusesController do

  let(:syllabus) { create(:syllabus) }

  before do
    login_admin
  end

  describe "GET index" do
    it "should be successful" do
      gaku_get :index
      response.should be_success
    end
  end 

  describe "POST create" do
    it "redirects to the new syllabus" do
      page.stub :save => true

      gaku_post :create, :syllabus => {:name => syllabus.name, :code => syllabus.code}
      response.should redirect_to(gaku.syllabus_url(Syllabus.last))
    end
  end

  describe "PUT update" do

    it "redirects to the syllabus" do
      page.stub :update_attributes => true

      gaku_post :update, :id => syllabus.id
      response.should redirect_to(gaku.syllabus_url(syllabus))
    end
  end

end
