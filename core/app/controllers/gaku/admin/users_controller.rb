module Gaku
  module Admin
    class UsersController < Admin::BaseController

      load_and_authorize_resource :class =>  Gaku::User

      inherit_resources
      respond_to :js, :html

      after_filter  :save_user_roles, :only => :create
      before_filter :save_user_roles, :only => :update
      before_filter :count, :only => [:create, :destroy, :index]
      before_filter :clean_password, :only => :update


      private

      def save_user_roles
        @user = User.find(params[:id]) if params[:id]
        @user.roles.delete_all
        params[:user][:role] ||= {}
        Role.all.each do |role|
          if params[:user][:role_ids].include?(role.id.to_s)
            @user.roles << role
          end
        end

        params[:user].delete(:role)
      end

      def count
        @count = User.count
      end

      def clean_password
        params[:user].delete(:password) if params[:user][:password].blank?
        params[:user].delete(:password_confirmation) if params[:user][:password_confirmation].blank?
      end

    end
  end
end
