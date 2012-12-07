module Gaku
  module Admin
    class Schools::Campuses::AddressesController < GakuController

    	inherit_resources
      actions :new, :edit, :update, :destoy

      respond_to :js, :html


      before_filter :address, :only => [:destroy, :make_primary]
    	before_filter :school
    	before_filter :campus
      before_filter :before_index, :only => [:index]

    	def create
        @address = Address.create(params[:address])
        @campus.address = @address
        respond_to do |format|
          if @campus.save
            flash.now[:notice] = t('notice.created', :resource => t('address.singular'))
            format.js { render 'create' }
          end
        end
      end

      def destroy
        @campus.address.destroy
        respond_to do |format|
          flash.now[:notice] = t('notice.destroyed', :resource => t('address.singular') )
          format.js { render 'destroy' }
        end
      end

      private
        def before_index
          @address = @campus.address
        end

        def address
          @address = Address.find(params[:id])
        end

        def school
          @school = School.find(params[:school_id])
        end

        def campus
          @campus = Campus.find(params[:campus_id])
        end

    end
  end
end
