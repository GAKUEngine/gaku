module Gaku
  class TeachersController < GakuController

    decorates_assigned :teacher

    respond_to :js,   only: %i( new create destroy recovery )
    respond_to :html, only: %i( index edit update show show_deleted soft_delete )

    before_action :set_unscoped_teacher, only: %i( show_deleted destroy recovery )
    before_action :set_teacher,          only: %i( edit show update soft_delete )

    def recovery
      @teacher.recover
      respond_with @teacher
    end

    def soft_delete
      @teacher.soft_delete
      respond_with @teacher, location: teachers_path
    end

    def destroy
      @teacher.destroy
      set_count
      respond_with @teacher
    end

    def show_deleted
      render :show
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
      respond_with @teacher
    end

    def show
      respond_with @teacher
    end

    def update
      @teacher.update(teacher_params)
      respond_with @teacher, location: [:edit, @teacher]
    end

    def index
      @search = Teacher.search(params[:q])
      results = @search.result(distinct: true)
      @teachers = results.page(params[:page])
      set_count
      respond_with @teachers
    end

    private

    def teacher_params
      params.require(:teacher).permit(attributes)
    end

    def attributes
      %i( name surname name_reading surname_reading birth_date gender picture )
    end

    def set_teacher
      @teacher = Teacher.find(params[:id])
      set_notable
    end

    def set_unscoped_teacher
      @teacher = Teacher.unscoped.find(params[:id])
      set_notable
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
