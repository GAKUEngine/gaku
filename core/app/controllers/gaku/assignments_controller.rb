module Gaku
  class AssignmentsController < GakuController

    inherit_resources

    def destroy
      @assignment = Assignment.find(params[:id])
      @assignment.destroy
      respond_to do |format|
        format.js { render nothing: true }
      end
    end

  end
end
