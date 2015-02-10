module Gaku
  class StudentSelectionController < GakuController

    respond_to :js,             only: %i( index add remove clear )
    before_action :user_selection
    before_action :set_student, only: %i( add remove )
    before_action :set_students, only: %i( collection remove_collection )

    def add
      @selection = @user_selection.add(@student)
      respond_with @selection
    end

    def remove
      @selection = @user_selection.remove(@student)
      set_count
      respond_with @selection
    end

    def collection
      @selection = @user_selection.collection(@students)
      render 'index'
    end

    def remove_collection
      @selection = @user_selection.remove_collection(@students)
      render 'index'
    end

    def index
      @selection = @user_selection.students
    end

    def clear
      @selection = @user_selection.remove_all
      respond_with @selection
    end

    private

    def set_student
      @student = Student.find(params[:id])
    end

    def set_students
      @students = Student.where(id: params[:student_ids])
    end

    def set_count
      @count = @selection.count
    end

    def user_selection
      @user_selection = Gaku::StudentSelection.new(current_user)
    end

  end
end
