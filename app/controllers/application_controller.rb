class ApplicationController < ActionController::Base
  before_filter :set_locale
  protect_from_forgery

  #def default_url_options(options={})
    # logger.debug "default_url_options is passed options: #{options.inspect}\n"
    # { :locale => I18n.locale }
  #end

  private

  def set_locale
    if current_user && params[:locale]
      current_user.locale = params[:locale]
      flash[:notice] = "Language is set to #{t('lang.' + current_user.locale)}" if current_user.save
    end

    if current_user
      I18n.locale = current_user.locale
    else
      I18n.locale = extract_locale_from_accept_language_header || I18n.default_locale
    end

  end

  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end

  def after_sign_in_path_for(resource_or_scope)
    I18n.locale = current_user.locale if !current_user.locale.blank?
    super
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

end
