shared_examples_for "allow" do |user_role|
  it "index for #{user_role}" do
    user = FactoryGirl.create("#{user_role}_user")
    login_as user, scope: :user

    gaku_get :index
    response.should be_success
    response.should render_template :index
  end
end

shared_examples_for "deny" do |user_role|
  it "index for #{user_role}" do
    user = FactoryGirl.create("#{user_role}_user")
    login_as user, scope: :user

    gaku_get :index
    response.should redirect_to "/"
    flash[:alert].should eq "You are not authorized to access this page."
  end
end

