module Gaku
  module Admin
    class Schools::Campuses::AddressesController < GakuController

    	inherit_resources
      respond_to :js, :html

    	before_filter :load_vars
      before_filter :before_index, :only => :index

      def destroy
        @address = Address.find(params[:id])
        @campus.address.destroy
        respond_with(@campus.address)
      end

      private

      def before_index
        @address = @campus.address
      end

      def load_vars
        @school = School.find(params[:school_id])
        @campus = Campus.find(params[:campus_id])
      end

    end
  end
end
