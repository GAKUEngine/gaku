module Gaku
  class Admin::UsersController < Admin::BaseController

    #load_and_authorize_resource class: User

    respond_to :js,   only: %i( new create edit update destroy )
    respond_to :html, only: :index

    before_action :set_user, only: %i( edit update destroy )
    before_action :set_roles

    def index
      @users = User.all.page(params[:page])
      @count = User.count
      respond_with @users
    end

    def new
      @user = User.new
      respond_with @user
    end

    def create
      @user = User.new(user_params)
      @user.save
      save_user_roles
      @count = User.count
      respond_with @user
    end

    def edit
    end

    def update
      clean_password
      save_user_roles
      @user.update(user_params)
      respond_with @user
    end

    def destroy
      @user.destroy
      @count = User.count
      respond_with @user
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(attributes)
    end

    def attributes
      [:login, :username, :email, :password, :password_confirmation, :remember_me, :locale, { role_ids: [] } ]
    end

    def set_roles
      @roles = Role.all
    end

    def save_user_roles
      if params[:user][:role_ids]
        @user.roles.destroy_all
        Role.all.each do |role|
          if params[:user][:role_ids].include?(role.id.to_s)
            @user.roles << role
          end
        end
      end
    end

    def clean_password
      params[:user].delete(:password) if params[:user][:password].blank?
      params[:user].delete(:password_confirmation) if params[:user][:password_confirmation].blank?
    end

  end
end
