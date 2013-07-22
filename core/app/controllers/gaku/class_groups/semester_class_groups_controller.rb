module Gaku
  class ClassGroups::SemesterClassGroupsController < GakuController

    load_and_authorize_resource :class_group, class: ClassGroup

    respond_to :js, :html

    inherit_resources

    belongs_to :class_group, parent_class: ClassGroup

    before_filter :count, only: %I(create destroy)
    before_filter :load_data, only: %I(new edit)

    protected

    def resource_params
      return [] if request.get?
      [params.require(:semester_class_group).permit(attributes)]
    end

    private

    def attributes
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
