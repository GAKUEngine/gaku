module Gaku
  class TeachersController < GakuController

    load_and_authorize_resource :teacher, :class => Gaku::Teacher

    inherit_resources
    respond_to :js, :html

    before_filter :count, :only => [:index, :create,:destroy]
    before_filter :notable, :only => :show

    def soft_delete
      @teacher = Teacher.find(params[:id])
      @teacher.update_attribute(:is_deleted, true)
      redirect_to teachers_path, :notice => t(:'notice.destroyed', :resource => t(:'teacher.singular'))
    end


    private

    def count
      @count = Teacher.count
    end

    def notable
      @notable = Teacher.unscoped.find(params[:id])
      @notable_resource = @notable.class.to_s.underscore.split('/')[1].gsub("_","-")
    end

  end
end
