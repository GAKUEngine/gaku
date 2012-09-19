module Admin
  class ContactTypesController < Admin::BaseController
   	
    inherit_resources

    actions :index, :show, :new, :create, :update, :edit, :destroy

    before_filter :load_contact_type, :only => [:edit, :update, :destroy]

    def new
      @contact_type = ContactType.new
      render 'new'  
    end

    def create
    	@contact_type = ContactType.new(params[:contact_type])
      if @contact_type.save
      	load_contact_types
        respond_to do |format|
          format.js
        end  
      end
    end
  
    def edit
      respond_to do |format|
        format.js { render }
      end
    end

    def update
      if @contact_type.update_attributes(params[:contact_type])
        respond_to do |format|
          format.js
        end  
      end
    end

    def destroy
      if @contact_type.destroy
        load_contact_types
        respond_to do |format|
          format.js { render 'destroy' }
        end
      end
    end

    private
      def load_contact_type
        @contact_type = ContactType.find(params[:id])
      end

      def load_contact_types
        @contact_types = ContactType.all
      end

  end
end