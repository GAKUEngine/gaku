class Gaku::Grading::Single::Score < Gaku::Grading::Single::BaseMethod

  def grade_exam
    @score = nil
    exam = @gradable
    exam.exam_portions.each_with_index do |exam_portion, index|
      ep_score = @student.exam_portion_scores.where(gradable_type: gradable_scope.class.to_s, gradable_id: gradable_scope.id, exam_portion_id: exam_portion.id).first_or_create!
      @score = @score.to_f + ep_score.score if ep_score.score
    end

    @result = { id: @student.id, score: @score }
  end

end
