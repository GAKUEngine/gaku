module Gaku
  module Admin
    class Schools::Campuses::ContactsController < GakuController

      inherit_resources
      respond_to :js, :html

      before_filter :campus
      before_filter :contact_types, :only => [:new, :edit]
      before_filter :count, :only => [:create, :destroy]
      before_filter :contact, :except => [:new, :create]
      
      def create
        super do |format|
          if @contact.save && @campus.contacts << @contact
            @contact.make_primary_campus if params[:contact][:is_primary] == "1"
          end
          format.js { render :create }
        end
      end

      def update
        @contacts = Contact.where(:campus_id => params[:campus_id])
        @contact.make_primary_campus if params[:contact][:is_primary] == "1"
        update!
      end

      def destroy
        @campus.contacts.first.make_primary_campus if @contact.is_primary?
        destroy!
      end

      def make_primary
        @contact = Contact.find(params[:id])
        @contact.make_primary_campus
        respond_with(@contact)
      end

      private

      def contact
        @contact = Contact.find(params[:id])
      end

      def campus
        @campus = Campus.find(params[:campus_id])
      end

      def contact_types
        @contact_types = ContactType.all
      end

      def count
        campus
        @count = @campus.contacts.count
      end

    end
  end
end
