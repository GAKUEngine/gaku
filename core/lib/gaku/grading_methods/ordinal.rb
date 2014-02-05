class  Gaku::GradingMethods::Ordinal < Gaku::GradingMethods::BaseMethod

  private

  def grade_exam
    @results = Hash.new { |hash, key| hash[key] = {} }
    @students.each do |student|
      @results[@gradable.id][student.id] = nil
      @gradable.exam_portions.each do |exam_portion|
        exam_portion_score =
          student.exam_portion_scores.where(exam_portion_id: exam_portion.id).first.try(:score)
        if exam_portion_score.present?
          @results[@gradable.id][student.id] =
            @results[@gradable.id][student.id].to_f +  exam_portion_score.to_f
        end
      end
    end
    @results
  end
end
