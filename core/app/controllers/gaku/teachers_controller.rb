module Gaku
  class TeachersController < GakuController

    load_and_authorize_resource :teacher, class: Gaku::Teacher

    inherit_resources
    respond_to :js, :html

    before_filter :count,   only: [:index, :create, :destroy]
    before_filter :notable, only: :show
    before_filter :teacher, only: [:soft_delete, :update]

    def soft_delete
      @teacher.update_attribute(:is_deleted, true)
      redirect_to teachers_path,
                  notice: t(:'notice.destroyed', resource: t(:'teacher.singular'))
    end

    def update
      super do |format|
        if params[:teacher][:picture]
          format.html do
            redirect_to @teacher,
                        notice: t(:'notice.uploaded', resource: t(:'picture'))
          end
        else
          format.js { render }
        end
      end
    end


    protected

    def collection
      @search = Teacher.search(params[:q])
      results = @search.result(distinct: true)

      @teachers = results.page(params[:page]).per(Preset.teachers_per_page)
    end

    def resource
      @teacher = Teacher.find(params[:id]).decorate
    end

    def resource_params
      return [] if request.get?
      [params.require(:teacher).permit(teacher_attr)]
    end

    private

    def teacher_attr
      %i(name surname name_reading surname_reading birth_date gender)
    end

    def count
      @count = Teacher.count
    end

    def teacher
      @teacher = Teacher.find(params[:id])
    end

    def notable
      @notable = Teacher.unscoped.find(params[:id])
      @notable_resource = get_resource_name @notable
    end

  end
end
