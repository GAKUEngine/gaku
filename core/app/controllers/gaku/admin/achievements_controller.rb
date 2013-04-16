module Gaku
  module Admin
    class AchievementsController < Admin::BaseController

      load_and_authorize_resource :class =>  Gaku::Achievement

      inherit_resources
      respond_to :js, :html

      before_filter :count, :only => [:index, :create, :destroy]

      def create
        create! { [:admin, :achievements ] }
      end

       def update
        update! { [:admin, :achievements ] }
      end

      private

      def count
        @count = Achievement.count
      end

    end
  end
end

