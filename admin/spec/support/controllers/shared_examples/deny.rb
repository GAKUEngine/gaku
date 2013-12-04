shared_examples_for 'deny' do |user_role|
  it "deny index for #{user_role}" do
    user = FactoryGirl.create("#{user_role}_user")
    login_as user, scope: :user

    gaku_get :index
    response.should redirect_to '/'
    flash[:alert].should eq 'You are not authorized to access this page.'
  end
end

shared_examples_for 'deny except' do |except_role|
  Gaku::Role.destroy_all

  %w(principal vice_principal).each do |role|
    unless role == except_role
      it "deny index for #{role}" do
        user = FactoryGirl.create("#{role}_user")
        login_as user, scope: :user

        gaku_get :index
        response.should redirect_to '/'
        flash[:alert].should eq 'You are not authorized to access this page.'
      end
    end
  end
end
