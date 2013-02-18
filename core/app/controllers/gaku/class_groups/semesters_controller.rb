module Gaku
  class ClassGroups::SemestersController < GakuController

    load_and_authorize_resource :class_group, :class => Gaku::ClassGroup
    load_and_authorize_resource :semester, :through => :class_group, :class => Gaku::Semester

    inherit_resources
    respond_to :js, :html
    belongs_to :class_group, :parent_class => Gaku::ClassGroup

    before_filter :count, :only => [:create, :destroy]

    private

    def count
      class_group = ClassGroup.find(params[:class_group_id])
      @count = class_group.semesters.count
    end

  end
end
