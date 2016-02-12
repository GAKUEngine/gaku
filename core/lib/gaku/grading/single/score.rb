class Gaku::Grading::Single::Score < Gaku::Grading::Single::BaseMethod

  def grade_exam
    @score = nil
    exam = @gradable
    exam.exam_portions.select(&:score?).each_with_index do |exam_portion, index|
      ep_score = @student.exam_portion_scores.find_by(gradable: gradable_scope, exam_portion_id: exam_portion.id)
      @score = @score.to_f + ep_score.score if ep_score.score
    end

    @result = { id: @student.id, score: @score }
  end

end
