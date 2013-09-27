module Gaku
  class TeachersController < GakuController

    #load_and_authorize_resource :teacher, class: Gaku::Teacher

    inherit_resources
    respond_to :js, :html

    before_filter :count,                only: %i( index create destroy )
    before_filter :notable,              only: %i( show show_deleted )
    before_action :set_unscoped_teacher, only: %i( show_deleted destroy recovery )
    before_action :set_teacher,          only: %i( edit update soft_delete )

    def recovery
      @teacher.recover
      flash.now[:notice] = t(:'notice.recovered', resource: t_resource)
      respond_with @teacher
    end

    def soft_delete
      @teacher.soft_delete
      redirect_to teachers_path,
                  notice: t(:'notice.destroyed', resource: t_resource)
    end

    def destroy
      @teacher.destroy
      respond_with @teacher
    end

    def show_deleted
      respond_with(@teacher) do |format|
        format.html { render :show }
      end
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
      %i(name surname name_reading surname_reading birth_date gender picture)
    end

    def count
      @count = Teacher.count
    end

    def set_teacher
      @teacher = Teacher.find(params[:id]).decorate
    end

    def set_unscoped_teacher
      @teacher = Teacher.unscoped.find(params[:id]).decorate
    end

    def t_resource
      t(:'teacher.singular')
    end

    def notable
      @notable = Teacher.unscoped.find(params[:id])
      @notable_resource = get_resource_name @notable
    end

  end
end
