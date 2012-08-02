module AuthenticationHelpers
  def sign_in_as!(user)
    visit '/users/sign_in'
    fill_in "user_email", :with => user.email
    fill_in "user_password", :with => 'secret'
    click_button "sign_in"
  end

  def login_admin
    @request.env["devise.mapping"] = Devise.mappings[:admin]
    sign_in Factory.create(:admin) # Using factory girl as an example
  end

  def login_user
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user = Factory.create(:user)
    user.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the confirmable module
    sign_in user
  end

end

RSpec.configure do |c|
  c.include AuthenticationHelpers, :type => :request
  c.include AuthenticationHelpers, :type => :controller
end