module AuthenticationHelpers
  def sign_in_as!(user)
    visit '/users/sign_in'
    fill_in "user_email", :with => user.email
    fill_in "user_password", :with => 'secret'
    click_button "sign_in"
  end
end

RSpec.configure do |c|
  c.include AuthenticationHelpers, :type => :request
end