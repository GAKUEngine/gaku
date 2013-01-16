module Gaku
  module Admin
    class Schools::Campuses::ContactsController < GakuController

      inherit_resources
      belongs_to :campus, :parent_class => Gaku::Campus

      respond_to :js, :html
      before_filter :campus
      before_filter :school, :only => [:create, :update]
      before_filter :contact_types, :only => [:new, :edit]
      before_filter :count, :only => [:create, :destroy]
      before_filter :contact, :except => [:new, :create]

      def destroy
        if @contact.destroy
          if @contact.is_primary?
            @campus.contacts.first.try(:make_primary)
          end
        end
        flash.now[:notice] = t(:'notice.destroyed', :resource => t(:'contact.singular'))
        destroy!
    end

      def make_primary
        @contact.make_primary
        respond_with(@contact)
      end

      private

      def school
        @school = School.find(params[:school_id])
      end

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
