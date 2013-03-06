module Gaku
  class Students::GuardiansController < GakuController

    load_and_authorize_resource :student, :class => Gaku::Student
    load_and_authorize_resource :guardian, :through => :student, :class => Gaku::Guardian

    inherit_resources
    #belongs_to :student, :parent_class => Gaku::Student
    respond_to :js, :html

    before_filter :student
    before_filter :count, :only => [:create,:destroy]

    def create
      super do |format|
        if @student.guardians << @guardian
          format.js { render }
        end
      end
    end

    private

    def student
      @student = Student.find(params[:student_id])
    end

    def guardian
      @guardian = Guardian.find(params[:id])
    end

    def count
      @count = @student.guardians.count
    end

  end
end
