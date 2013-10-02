module Gaku
  class TeachersController < GakuController

    #load_and_authorize_resource :teacher, class: Gaku::Teacher

    decorates_assigned :teacher

    respond_to :js,   only: %i( new create edit update destroy recovery )
    respond_to :html, only: %i( index edit update show show_deleted soft_delete )

    before_action :set_unscoped_teacher, only: %i( show_deleted destroy recovery )
    before_action :set_teacher,          only: %i( edit show update soft_delete )

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
      set_count
      respond_with @teacher
    end

    def show_deleted
      respond_with(@teacher) do |format|
        format.html { render :show }
      end
    end

    def new
      @teacher = Teacher.new
      respond_with @teacher
    end

    def create
      @teacher = Teacher.new(teacher_params)
      @teacher.save
      set_count
      respond_with @teacher
    end

    def edit
    end

    def show
    end

    def update
      @teacher.update(teacher_params)
      respond_with(@teacher) do |format|
        if params[:teacher][:picture]
          format.html do
            redirect_to @teacher,
                        notice: t(:'notice.uploaded', resource: t(:'picture'))
          end
        else
          format.js { render }
          format.html { redirect_to [:edit, @teacher] }
        end
      end
    end

    def index
      @search = Teacher.search(params[:q])
      results = @search.result(distinct: true)
      @teachers = results.page(params[:page]).per(Preset.teachers_per_page)
      set_count
      respond_with @teachers
    end

    private

    def teacher_params
      params.require(:teacher).permit(attributes)
    end

    def attributes
      %i(name surname name_reading surname_reading birth_date gender picture)
    end

    def set_teacher
      @teacher = Teacher.find(params[:id])
      set_notable
    end

    def set_unscoped_teacher
      @teacher = Teacher.unscoped.find(params[:id])
      set_notable
    end

    def t_resource
      t(:'teacher.singular')
    end

    def set_notable
      @notable = @teacher
      @notable_resource = get_resource_name @notable
    end

    def set_count
      @count = Teacher.count
    end

  end
end
