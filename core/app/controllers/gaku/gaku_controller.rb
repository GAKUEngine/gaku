require "gaku/core/app_responder"

module Gaku
  class GakuController < ActionController::Base
    protect_from_forgery
    check_authorization

    rescue_from CanCan::AccessDenied do |exception|
      redirect_to root_url, :alert => exception.message
    end

    before_filter :set_locale

    layout :resolve_layout

    self.responder = Core::AppResponder
    respond_to :html

    def user_for_paper_trail
      user_signed_in? ? current_user : 'Public user'  # or whatever
    end


    private

    def current_ability
      @current_ability ||= Gaku::Ability.new(current_user)
    end

    def resolve_layout
      case action_name
      when "index"
        "gaku/layouts/index"
      when "show"
        "gaku/layouts/show"
      else
        "gaku/layouts/gaku"
      end
    end

    def set_locale
      if current_user && params[:locale]
        I18n.locale = params[:locale]
        current_user.settings[:locale] = params[:locale]
        flash[:notice] = "Language is set to #{t('languages.' + current_user.locale)}" if current_user.save
      elsif current_user
        I18n.locale = current_user.settings[:locale] #|| Gaku::Preset.get('language')
      else
        I18n.default_locale
      end
    end

    def extract_locale_from_accept_language_header
      request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
    end

    def after_sign_in_path_for(resource_or_scope)
      I18n.locale = current_user.settings[:locale] unless current_user.settings[:locale].blank?
      super
    end

    def after_sign_out_path_for(resource_or_scope)
      root_path
    end

  end
end
