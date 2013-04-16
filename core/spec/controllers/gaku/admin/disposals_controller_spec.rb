require 'spec_helper'

describe Gaku::Admin::DisposalsController do

  as_admin

  describe "GET #exams" do
    it "is successful" do
      gaku_get :exams
      response.should be_success
    end

    it "renders the :exams view" do
      gaku_get :exams
      response.should render_template :exams
    end
  end

  describe "GET #course_groups" do

    it "is successful" do
    gaku_get :course_groups
    response.should be_success
  end

  it "renders the :course_groups view" do
    gaku_get :course_groups
    response.should render_template :course_groups
    end
  end

  describe "GET #attachments" do
    it "is successful" do
    gaku_get :attachments
    response.should be_success
  end

  it "renders the :attachments view" do
    gaku_get :attachments
    response.should render_template :attachments
    end
  end

end
