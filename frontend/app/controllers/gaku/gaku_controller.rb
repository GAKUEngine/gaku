module Gaku
  class GakuController < CoreController

    self.responder = AppResponder
    respond_to :html

    layout :resolve_layout

    before_action :require_login

    def resolve_layout
      case action_name
      when 'index'
        'gaku/layouts/index'
      when 'show'
        'gaku/layouts/show'
      when 'edit'
        'gaku/layouts/edit'
      else
        'gaku/layouts/gaku'
      end
    end


    private

    def require_login
      unless current_user
        redirect_to new_user_session_path
      end
    end

  end
end
