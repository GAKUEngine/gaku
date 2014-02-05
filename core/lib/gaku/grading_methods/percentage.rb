class  Gaku::GradingMethods::Percentage < Gaku::GradingMethods::BaseMethod

  private

  def grade_exam
    @results = Hash.new { |hash, key| hash[key] = {} }
    @students.each do |student|
      @results[@exam.id][student.id] = nil
      @exam.exam_portions.each do |exam_portion|
        exam_portion_percentage =
          student.exam_portion_scores.where(exam_portion_id: exam_portion.id)
            .first.try(:score) / exam_portion.max_score
        if exam_portion_percentage.present?
          @results[@exam.id][student.id] =
            @results[@exam.id][student.id].to_f +  exam_portion_percentage.to_f
        end
      end
    end
    @results
  end
end
