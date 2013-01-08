module Gaku
  module Admin
    class AttendancesController < GakuController
      inherit_resources

      respond_to :js, :json

      def create
        exam_portion_score = ExamPortionScore.find(params[:exam_portion_score_id])
        @attendance = exam_portion_score.attendances.build(
                        :student_id => exam_portion_score.student_id,
                        :attendance_type_id => params[:attendance][:attendance_type_id],
                        :reason => params[:attendance][:reason] )
        if @attendance.save
          respond_with(@attendance) do |format|
            format.json { render :json => @attendance.to_json(:root => false)}
          end
        end
      end

      def show
        super do |format|
          format.json { render :json => @attendance.as_json(:root => false, :include => :attendance_type) }

        end
      end
    end
  end
end