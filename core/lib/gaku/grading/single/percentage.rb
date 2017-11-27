class Gaku::Grading::Single::Percentage < Gaku::Grading::Single::BaseMethod

  attr_reader :scores

  def grade_exam
    exam = @gradable

    @scores = []
    @max_score = exam.max_score
    exam.exam_portions.select(&:score?).each_with_index do |exam_portion, index|
      ep_score = @student.exam_portion_scores.find_by(gradable: gradable_scope, exam_portion_id: exam_portion.id)
      @scores << ep_score.score if ep_score.score
    end

    @result = { id: @student.id, score: formated_score }
  end

  def score
    @scores.inject(:+) / @max_score unless @scores.blank?
  end

  def formated_score
    score.try(:*, 100).try(:round, 3)
  end
end
