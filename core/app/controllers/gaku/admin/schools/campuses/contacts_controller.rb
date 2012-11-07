module Gaku
  module Admin
    class Schools::Campuses::ContactsController < GakuController

      inherit_resources
      actions :index, :show, :create, :update, :edit, :destroy

      respond_to :js, :html

      before_filter :load_campus, :only => [ :new, :create, :edit, :update, :destroy ]

      def create
        super do |format|
          if @contact.save && @campus.contacts << @contact
            @contact.make_primary_campus if params[:contact][:is_primary] == "1"
          end
          format.js { render 'create' }
        end
      end

      def update
        super do |format|
          @contacts = Contact.where(:campus_id => params[:campus_id])
          @contact.make_primary_campus if params[:contact][:is_primary] == "1"
          format.js { render 'update' }  
        end  
      end

      def destroy
        super do |format|
          if @contact.is_primary?
            @campus.contacts.first.make_primary_campus if @student.contacts.any?
            format.js { render }
          else
            format.js { render 'destroy' }
          end

        end
      end 

      def make_primary
        @contact = Contact.find(params[:id])
        @contact.make_primary_campus

        respond_with(@contact) do |format|
          format.js { render 'make_primary' }
        end
      end

      private 
        def load_campus
          @campus = Campus.find(params[:campus_id])
        end
    end
  end
end