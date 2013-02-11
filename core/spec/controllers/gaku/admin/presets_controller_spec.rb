require 'spec_helper'

describe Gaku::Admin::PresetsController do

  as_admin

  describe "GET #students" do
    it "is successful" do
      gaku_get :students
      response.should be_success
    end

    it "renders the :students view" do
      gaku_get :students
      response.should render_template :students
    end
  end

  describe "GET #locale" do

    it "is successful" do
    gaku_get :locale
    response.should be_success
  end

  it "renders the :locale view" do
    gaku_get :locale
    response.should render_template :locale
    end
  end

  describe "GET #grading" do
    it "is successful" do
    gaku_get :grading
    response.should be_success
  end

  it "renders the :grading view" do
    gaku_get :grading
    response.should render_template :grading
    end
  end

end
