shared_examples_for "allow" do |user_role|
  it "allow index for #{user_role}" do
    user = FactoryGirl.create("#{user_role}_user")
    login_as user, scope: :user

    gaku_get :index
    response.should be_success
    response.should render_template :index
  end
end

shared_examples_for "deny" do |user_role|
  it "deny index for #{user_role}" do
    user = FactoryGirl.create("#{user_role}_user")
    login_as user, scope: :user

    gaku_get :index
    response.should redirect_to "/"
    flash[:alert].should eq "You are not authorized to access this page."
  end
end

shared_examples_for "deny except" do |except_role|
  Gaku::Role.destroy_all

  %w(principal vice_principal).each do |role|
    unless role == except_role
      it "deny index for #{role}" do
        user = FactoryGirl.create("#{role}_user")
        login_as user, scope: :user

        gaku_get :index
        response.should redirect_to "/"
        flash[:alert].should eq "You are not authorized to access this page."
      end
    end
  end
end


shared_examples_for 'person' do
  it { should validate_presence_of :name }
  it { should validate_presence_of :surname }
end

shared_examples_for 'addressable' do
  it { should have_many :addresses }
end

shared_examples_for 'notable' do
  it { should have_many :notes }
end

shared_examples_for 'contactable' do
  it { should have_many :contacts }
end

shared_examples_for 'avatarable' do
  it { should have_attached_file :picture }
end
