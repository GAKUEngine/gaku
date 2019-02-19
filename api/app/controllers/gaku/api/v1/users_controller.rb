module Gaku
  module Api
    module V1
      class UsersController < BaseController
        before_action :set_user, only: %i[ update ]

        def index
          @users = User.all
          collection_respond_to @users, root: :users
        end

        def create
          @user = User.new(create_user_params)
          if @user.save!
            member_respond_to @user
          end
        end

        def update
          if @user.update!(update_update_params)
            member_respond_to @user
          end
        end

        private

        def set_user
          @user = Gaku::User.find(params[:id])
        end

        def create_user_params
          params.require %i[email username password]
          params.permit %i[email username password disabled disabled_until]
        end

        def update_user_params
          params.permit %i[email username password disabled disabled_until]
        end

      end
    end
  end
end
