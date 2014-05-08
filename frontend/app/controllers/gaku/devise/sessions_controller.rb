class Gaku::Devise::SessionsController < Devise::SessionsController
  # helper Gaku::GakuHelper
  layout 'gaku/layouts/gaku'

  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
    redirect_to session['previous_url'] || root_path
  end

end
