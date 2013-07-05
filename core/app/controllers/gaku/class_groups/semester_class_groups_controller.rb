module Gaku
  class ClassGroups::SemesterClassGroupsController < GakuController

    load_and_authorize_resource :class_group, class: Gaku::ClassGroup

    inherit_resources
    respond_to :js, :html
    belongs_to :class_group, parent_class: Gaku::ClassGroup

    before_filter :count, only: [:create, :destroy]
    before_filter :load_data, only: [:new, :edit]

    protected

    def resource_params
      return [] if request.get?
      [params.require(:semester_class_group).permit(semester_class_group_attr)]
    end

    private

    def semester_class_group_attr
      %i(semester_id)
    end

    def load_data
      @semesters = Semester.all.collect { |s| [s.to_s, s.id] }
    end

    def count
      class_group = ClassGroup.find(params[:class_group_id])
      @count = class_group.semesters.count
    end

  end
end
