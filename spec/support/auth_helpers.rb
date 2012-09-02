module AuthHelpers
  module Controller
    def stub_authorization!
      before do
        controller.should_receive(:authorize!).twice.and_return(true)
      end
    end
  end

  module Request
    class SuperAbility
      include CanCan::Ability

      def initialize(user)
        # allow anyone to perform index on Order
        can :manage, :all
      end
    end

    def stub_authorization!
      before(:all) { Ability.register_ability(AuthHelpers::Request::SuperAbility) }
      after(:all) { Ability.remove_ability(AuthHelpers::Request::SuperAbility) }
    end

    def sign_in_as!(user)
      visit '/users/sign_in'
      fill_in "user_email", :with => user.email
      fill_in "user_password", :with => 'secret'
      click_button "sign_in"
    end
    
  end
end

RSpec.configure do |config|
  config.extend AuthHelpers::Controller, :type => :controller
  config.extend AuthHelpers::Request, :type => :request
end