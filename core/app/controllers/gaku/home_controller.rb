module Gaku
	class HomeController < GakuController

    skip_authorization_check

	  def index
	    unless user_signed_in?
	      redirect_to new_user_session_path
	    end
	  end
	end
end
