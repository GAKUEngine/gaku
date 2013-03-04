class Gaku::Devise::RegistrationsController < Devise::RegistrationsController
	helper Gaku::GakuHelper
	layout "gaku/layouts/gaku"

  def set_up_admin_account
    resource = build_resource({})
    respond_with resource
  end

  def create_admin
    build_resource
    admin_role = Gaku::Role.find_by_name('Admin')
    resource.roles << admin_role

    if resource.save
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_up(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end
end