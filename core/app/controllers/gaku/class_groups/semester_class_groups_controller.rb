module Gaku
  class ClassGroups::SemesterClassGroupsController < GakuController

    respond_to :js, only: %i( new create edit update destroy )

    before_action :set_class_group
    before_action :set_semester_class_group, only: %i( edit update destroy )
    before_action :set_semesters, only: %i( new edit )

    def new
      @semester_class_group = SemesterClassGroup.new
    end

    def create
      @semester_class_group = @class_group.semester_class_groups.build(semester_class_group_params)
      @semester_class_group.save
      set_count
      respond_with @semester_class_group
    end

    def edit
    end

    def update
      @semester_class_group.update(semester_class_group_params)
      respond_with @semester_class_group
    end

    def destroy
      @semester_class_group.destroy
      set_count
      respond_with @semester_class_group
    end

    private

    def semester_class_group_params
      params.require(:semester_class_group).permit(attributes)
    end

    def attributes
      %i( semester_id )
    end

    def set_semesters
      @semesters = Semester.all
    end

    def set_class_group
      @class_group =  ClassGroup.find(params[:class_group_id])
    end

    def set_semester_class_group
      #@semester_class_group =  SemesterClassGroup.find(params[:id])
      @semester_class_group =  @class_group.semester_class_groups.find(params[:id])
    end

    def set_count
      @count = @class_group.semesters.count
    end

  end
end
