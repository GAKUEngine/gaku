class Gaku::Grading::Single::Percentage < Gaku::Grading::Single::BaseMethod

  def grade_exam
    @score = 0.0
    exam = @gradable

    exam.exam_portions.each_with_index do |exam_portion, index|
      ep_score = @student.exam_portion_scores.where(exam_portion_id: exam_portion.id).first_or_create!(score: 0)
      ep_percentage = ep_score.score / exam_portion.max_score
      @score += ep_percentage
    end

    @result = { id: @student.id, score: @score }
  end

end
