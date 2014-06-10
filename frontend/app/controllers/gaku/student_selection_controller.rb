module Gaku
  class StudentSelectionController < GakuController

    respond_to :js,             only: %i( index add remove clear )
    before_action :set_student, only: %i( add remove )

    def add
      @selection = Gaku::StudentSelection.add(@student)
      respond_with @selection
    end

    def remove
      @selection = Gaku::StudentSelection.remove(@student)
      respond_with @selection
    end

    def index
      @selection = Gaku::StudentSelection.all
      respond_with @selection
    end

    def clear
      @selection = Gaku::StudentSelection.remove_all
      respond_with @selection
    end

    private

    def set_student
      @student = Student.find(params[:id])
    end

  end
end
