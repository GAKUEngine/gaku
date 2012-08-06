class ExamPortionScoresController < ApplicationController
  inherit_resources

   def update
    @exam_portion_score = ExamPortionScore.find(params[:id])
    if @exam_portion_score.update_attributes(params[:exam_portion_score])
      respond_to do |format|
        format.js { render :nothing => true } 
      end
    else
      #render :edit
    end
  end
  #actions :new, :index, :create, :update, :edit, :destroy

 # def index
 #   if !(params.has_key?(:course_id) && params.has_key?(:exam_id))
 #     render :text => "No Course Specified"
 #     return
 #   end

 #   @course = Course.find(params[:course_id])
 #   @students = @course.students
 #   @exam = Exam.find(params[:exam_id])
 #   @exam_portions = @exam.exam_portions

 #   @scores = []
 #   @students.each do |student|
 #     studentScore = {:surname => student.surname, :name => student.name, :student_id => student.id, :scores => []}
 #     @exam.exam_portions.each do |portion|
 #       score = student.exam_portion_scores.where(:exam_portion_id => portion.id)
 #       if score
 #         score = ExamPortionScore.new
 #         score.student_id = student.id
 #         score.exam_portion_id = portion.id
 #         score.save
 #       end
 #       studentScore[:scores].push(score)
 #     end
 #     @scores.push(studentScore)
 #   end

 #   respond_to do |format|
 #     #format.html { render "exams/grading" }
 #     format.json { render :json => @scores }
 #   end
 # end
end
