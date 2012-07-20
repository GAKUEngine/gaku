require 'spec_helper'

describe SyllabusesController do

  let(:syllabus) { FactoryGirl.create(:syllabus) }

  before do
    login_admin
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

  describe "PUT update" do

    it "redirects to the syllabus" do
      page.stub :update_attributes => true

      post :update, :id => syllabus.id
      response.should redirect_to(syllabus_url(syllabus))
    end
  end

  describe "destroying a syllabus" do

    it "doesn't set the flash on xhr requests'" do
      xhr :delete, :destroy, :id => syllabus
      controller.should_not set_the_flash
    end

    it "sets the flash" do
      delete :destroy, :id => syllabus
      controller.should set_the_flash
    end
  end

  describe 'PUT create_exam ' do
    it "should create new exam with ajax" do
      expect do  
        xhr :put, :create_exam, :id => syllabus.id, :syllabus => {:exam =>  { "name" => "Test exam",
                                                                                              "description" =>"Test exam description",
                                                                                              "adjustments" => "Test exam adjustments",
                                                                                              "weight" => 2,
                                                                                              "dynamic_scoring"=> true,
                                                                                              :exam_portions_attributes => {0 => {"weight" => 1,
                                                                                                                                  "problem_count" => 1,
                                                                                                                                  "max_score" => 1}}}}
      end.to change(Exam, :count).by(1)
    end
  end

  describe 'PUT create_assignment ' do
    it "should create new assignment with ajax" do
      expect do  
        xhr :put, :create_assignment, :id => syllabus.id, :syllabus => {:assignments_attributes => {0 => {"name" => "Test assignment",
                                                                                                          "description" =>"Test assignment description",
                                                                                                          "max_score" => 2}}}
      end.to change(Assignment, :count).by(1)
    end
  end
end
