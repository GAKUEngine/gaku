class  Gaku::GradingMethods::Percentage < Gaku::GradingMethods::BaseMethod

  private

  def grade_exam
    @exam = gradable

    @results = Hash.new { |hash, key| hash[key] = {} }

    @students.each do |student|
      #@results[:exam] = @exam.id
      @results[@exam.id][student.id] = nil

      puts @exam.exam_portions.count

      @exam.exam_portions.each do |exam_portion|
        ep_score = student.exam_portion_scores.where(exam_portion_id: exam_portion.id).first_or_create!(score: 0)
        ep_percentage = ep_score.score / exam_portion.max_score

        if ep_percentage.present?
          @results[@exam.id][student.id] =
            @results[@exam.id][student.id].to_f +  ep_percentage.to_f
        end
      end
    end

    @results
  end


end
