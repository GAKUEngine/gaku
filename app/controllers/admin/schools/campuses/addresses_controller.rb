module Admin
  class Schools::Campuses::AddressesController < ApplicationController
  	
  	inherit_resources
    actions :new, :edit, :update, :destoy

    respond_to :js, :html

    before_filter :address, :only => [:destroy, :make_primary]
  	before_filter :school, :only => [:new, :create, :edit, :update]
  	before_filter :campus

  	def create  
      super do |format|
        @address = Address.create(params[:address])
        @campus.address = @address
        if @campus.save
          format.js { render 'create' }  
        end
      end
    end


    def destroy
      @campus.address.destroy
      respond_to do |format|
        format.js { render 'destroy' }
      end
    end
    
    private

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