module Gaku
  class ClassGroups::SemesterClassGroupsController < GakuController

    load_and_authorize_resource :class_group, :class => Gaku::ClassGroup
    # load_and_authorize_resource :semester, :through => :class_group, :class => Gaku::Semester

    inherit_resources
    respond_to :js, :html
    belongs_to :class_group, :parent_class => Gaku::ClassGroup

    before_filter :count, :only => [:create, :destroy]
    before_filter :load_data, only: [:new, :edit]

    private

    def load_data
      @semesters = Semester.all.collect { |s| [s.to_s, s.id] }
    end

    def count
      class_group = ClassGroup.find(params[:class_group_id])
      @count = class_group.semesters.count
    end

  end
end
