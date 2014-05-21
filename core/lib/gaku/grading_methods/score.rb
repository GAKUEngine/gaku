class  Gaku::GradingMethods::Score < Gaku::GradingMethods::BaseMethod

  private

  def grade_exam(exam)
    Gaku::GradingMethods::Result.new(exam.id).tap do |result|
      @students.each do |student|
        @score = nil

        exam.exam_portions.each do |exam_portion|
          ep_score = student.exam_portion_scores.where(exam_portion_id: exam_portion.id).first_or_create!(score: 0)
          @score = @score.to_f + ep_score.score.to_f
        end

        result.append_score(student.id, @score)
      end
    end.as_json

  end
end
