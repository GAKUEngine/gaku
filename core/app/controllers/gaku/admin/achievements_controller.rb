module Gaku
  module Admin
    class AchievementsController < Admin::BaseController
      inherit_resources
      respond_to :js, :html, :json

      before_filter :count, :only => [:index, :create, :destroy]

      def create
        super do |format|
          format.html { redirect_to_index }
        end
      end

       def update
        super do |format|
          format.html { redirect_to_index }
        end
      end

      private

      def count
        @count = Achievement.count
      end

      def redirect_to_index
        redirect_to [:admin, :achievements ]
      end

    end
  end
end

