module Gaku
  class StudentSelectionController < GakuController

    respond_to :js,             only: %i( index add remove clear )
    before_action :set_student, only: %i( add remove )
    before_action :set_students, only: %i( collection remove_collection )

    def add
      @selection = Gaku::StudentSelection.add(@student)
      respond_with @selection
    end


    def remove
      @selection = Gaku::StudentSelection.remove(@student)
      respond_with @selection
    end

    def collection
      @selection = Gaku::StudentSelection.collection(@students)
      render 'index'
    end

    def remove_collection
      @selection = Gaku::StudentSelection.remove_collection(@students)
      render 'index'
    end

    def index
      @selection = Gaku::StudentSelection.all
    end

    def clear
      @selection = Gaku::StudentSelection.remove_all
      respond_with @selection
    end

    private

    def set_student
      @student = Student.find(params[:id])
    end

    def set_students
      @students = Student.where(id: params[:student_ids] )
    end

  end
end
