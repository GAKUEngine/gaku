module Gaku
  class Admin::SchoolsController < Admin::BaseController

    load_and_authorize_resource class: School

    respond_to :js, :html

    inherit_resources

    before_filter :count, only: %i(create destroy index)
    before_filter :master_school, only: %i(index school_details edit_master)

    def school_details
      @school = @master_school
      render :show, layout: 'gaku/layouts/show'
    end

    def edit_master
      render :edit_master, layout: 'gaku/layouts/show'
    end

    def update
      @school = School.find(params[:id])
      super do |format|
        if params[:school][:picture]
          format.html do
            redirect_to [:admin, @school],
                        notice: t(:'notice.uploaded', resource: t(:'picture'))
          end
        else
          format.js { render }
         end
      end
    end

    protected

    def resource_params
      return [] if request.get?
      [params.require(:school).permit(attributes)]
    end

    private

    def master_school
      @master_school = School.primary
    end

    def count
      @count = School.count
    end

    def attributes
      [:name, :primary, :slogan, :description, :founded, :principal, :vice_principal, :grades, :code, { levels_attributes: [ :name, :'_destroy', :id ] }, :picture ]
    end

  end

end
