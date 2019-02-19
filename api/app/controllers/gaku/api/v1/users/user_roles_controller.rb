module Gaku
  module Api
    module V1
      module Users
        class UserRolesController < BaseController
          before_action :set_role
          before_action :set_user

          def create
            @user.roles << @role
            member_respond_to @role
          end

          private

          def set_role
            @role = Role.find(params[:role_id])
          end

          def set_user
            @user = User.find(params[:user_id])
          end

        end
      end
    end
  end
end
