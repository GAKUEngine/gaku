module Admin
  class Schools::Campuses::ContactsController < ApplicationController

    inherit_resources

    actions :index, :show, :create, :update, :edit, :destroy

    before_filter :load_campus, :only => [ :new, :create, :edit, :update, :destroy ]

    def new
      @contact = Contact.new
      super do |format|
        format.js { render 'new' }
      end 
    end
    
    def create
      super do |format|
        if @contact.save && @campus.contacts << @contact
          @contact.make_primary_campus if params[:contact][:is_primary] == "1"
        end
        format.js { render 'create' }
      end
    end

    def edit
      super do |format|
        format.js { render 'edit' }  
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
