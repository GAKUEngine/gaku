module Gaku
  class StudentSelectionController < GakuController

    respond_to :js,             only: %i( index add remove clear )
    before_action :set_student, only: %i( add remove )

    def add
      @student.add_to_selection
      set_selection
      respond_with @selection
    end

    def remove
      @student.remove_from_selection
      set_selection
      respond_with @selection
    end

    def index
      set_selection
      respond_with @selection
    end

    def clear
      @selection = current_user.clear_student_selection
      respond_with @selection
    end

    private

    def set_student
      @student = Student.find(params[:id])
    end

    def set_selection
      @selection = current_user.student_selection
    end

  end
end

