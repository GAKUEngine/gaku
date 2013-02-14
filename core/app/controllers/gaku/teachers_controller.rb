module Gaku
  class TeachersController < GakuController

    load_and_authorize_resource :teacher, :class => Gaku::Teacher

    inherit_resources
    respond_to :js, :html

    before_filter :count, :only => [:index, :create,:destroy]
    before_filter :notable, :only => :show
    before_filter :teacher, :only => [:soft_delete, :update]

    def soft_delete
      @teacher = Teacher.find(params[:id])
      @teacher.update_attribute(:is_deleted, true)
      redirect_to teachers_path, :notice => t(:'notice.destroyed', :resource => t(:'teacher.singular'))
    end

    def update
      super do |format|
        if params[:teacher][:picture]
          format.html { redirect_to @teacher, :notice => t('notice.uploaded', :resource => t('picture')) }
        else
          format.js { render }
         end
      end
    end

    private

    def count
      @count = Teacher.count
    end

    def teacher
      @teacher = Teacher.find(params[:id])
    end

    def notable
      @notable = Teacher.unscoped.find(params[:id])
      @notable_resource = @notable.class.to_s.underscore.split('/')[1].gsub("_","-")
    end

  end
end
