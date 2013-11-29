module Gaku
  class Courses::ExamsController < GakuController

    respond_to :html


    def grading

      def fix_digit num, digit_num
        for_fix = 10 ** digit_num
        num = num * for_fix
        if num.nan?
          num = 0
        else
          num = num.truncate.to_f / for_fix.to_f
        end
        return num
      end

      # init: variables -------- {
      @course = Course.find(params[:course_id])
      @exam = Exam.find(params[:id])
      @students = @course.students
      init_portion_scores

      if params[:id] != nil
        @exams = Exam.find_all_by_id(params[:id])
      else
        @exams = @course.syllabus.exams.all
      end

      @student_total_scores = Hash.new { |hash,key| hash[key] = {} }
      @student_total_weights = Hash.new { |hash,key| hash[key] = {} }
      @exam_averages = Hash.new {0.0}
      @exam_weight_averages = Hash.new {0.0}
      # -------- }
      
      # set ExamPortionScores & calc for exams average -------- {
      @students.each do |student|
        @exams.each do |exam|
          @student_total_scores[student.id][exam.id] = 0.0
          @student_total_weights[student.id][exam.id] = 0.0
          exam.exam_portions.each do |portion|
            if student.exam_portion_scores.where(exam_portion_id: portion.id).first.nil?
              score = ExamPortionScore.new
              score.student_id = student.id
              score.exam_portion_id = portion.id
              score.save
            else
              @student_total_scores[student.id][exam.id] += student.exam_portion_scores.where(exam_portion_id: portion.id).first.score.to_f
              if exam.use_weighting
                @student_total_weights[student.id][exam.id] += (portion.weight.to_f / 100) * student.exam_portion_scores.where(exam_portion_id: portion.id).first.score.to_f
              end
            end
          end
          # calc for average --------
          @exam_averages[exam.id] += @student_total_scores[student.id][exam.id]
          if exam.use_weighting
            @exam_weight_averages[exam.id] += @student_total_weights[student.id][exam.id]
          end
        end
      end
      # -------- }

      # set Exams Average -------- {
      @exams.each do |exam|
        @exam_averages[exam.id] = fix_digit @exam_averages[exam.id] / @students.length, 4
        if exam.use_weighting
          @exam_weight_averages[exam.id] = fix_digit @exam_weight_averages[exam.id] / @students.length, 4
        end
      end
      # -------- }

      # calc for deviation -------- {
      @deviation = Hash.new { |hash,key| hash[key] = {} }
      stdDev = 0.0
      devMem = 0.0
      @exams.each do |exam|
        @students.each do |student|
          if exam.use_weighting
            stdDev += (@student_total_weights[student.id][exam.id] - @exam_weight_averages[exam.id]) ** 2
          else
            stdDev += (@student_total_scores[student.id][exam.id] - @exam_averages[exam.id]) ** 2
          end
        end
        stdDev = Math.sqrt stdDev / @students.length
        @students.each do |student|
          @deviation[student.id][exam.id] = 0.0
          if exam.use_weighting
            devMem = (@student_total_weights[student.id][exam.id] - @exam_weight_averages[exam.id]) / stdDev
          else
            devMem = (@student_total_scores[student.id][exam.id] - @exam_averages[exam.id]) / stdDev
          end

          if devMem.nan?
            @deviation[student.id][exam.id] = 50
          else
            @deviation[student.id][exam.id] = fix_digit devMem * 10 + 50, 4
          end
        end
      end
      # -------- }

      # WIP Grade and Rank Calculation -----↓
      @grades = Hash.new { |hash,key| hash[key] = {} }
      gradeLevels_Deviation = [100, 66, 62, 58, 55, 59, 45, 37, 0]
      gradeLevels_Percent = [5, 5, 10, 10, 30, 10, 100]

      @ranks = Hash.new { |hash,key| hash[key] = {} }
      rankLevels = [15, 20]

      @exams.each do |exam|
        scores = []
        if exam.use_weighting
          @students.each do |student|
            scores.push [@student_total_weights[student.id][exam.id], student.id]
          end
        else
          @students.each do |student|
            scores.push [@student_total_scores[student.id][exam.id], student.id]
          end
        end
        scores.sort!().reverse!()


        # WIP Grade Calculation -----↓

        # @grading_method = GradingMethod.find(exam.grading_method_id)
        # puts "@grading_method-------------"
        # puts @grading_method.name
        # eval @grading_method.method

        gradingMethod = 1
        gradePoint = 10
        case gradingMethod

        # calc for zentai
        when 1
          gradeLevels_Deviation.each_with_index do |glevel, i|
            @students.each do |student|
              if gradeLevels_Deviation[i] > @deviation[student.id][exam.id] && gradeLevels_Deviation[i+1] <= @deviation[student.id][exam.id]
                @grades[exam.id][student.id] = gradePoint
              end
            end
            gradePoint -= 1
          end

        # calc for soutai
        when 2
          scoresMem = scores.clone
          gradeNums = []
          gradeLevels_Percent.each do |glevel|
            gradeNums.push((@students.length * (glevel.to_f / 100)).ceil)
          end
          gradeNums.each do |gnum|
            i = 0
            while i < gnum && scoresMem.length != 0
              @grades[exam.id][scoresMem.shift[1]] = gradePoint
              i += 1
            end
            gradePoint -= 1
          end
        end

        # Rank Calculation -----↓
        rankPoint = 5
        @students.each do |student|
          @ranks[exam.id][student.id] = 3
        end
        rankNums = []
        rankLevels.each do |rlevel|
          rankNums.push((@students.length * (rlevel.to_f / 100)).ceil)
        end
        rankNums.each do |rnum|
          i = 0
          while i < rnum && scores.length != 0
            scoreMem = scores.shift()
            @ranks[exam.id][scoreMem[1]] = rankPoint
            if scores.length != 0 and scoreMem[0] == scores[0][0]
              rnum += 1
            end
            i += 1
          end
          rankPoint -= 1
        end
        scores.each do |score|
          if @grades[exam.id][socre[1]] == 3
            @ranks[exam.id][score[1]] = 2
          elsif @grades[exam.id][socre[1]] < 3
            @ranks[exam.id][score[1]] = 1
          end
        end
      end


      respond_with @exam
    end

    private

    def init_portion_scores
      @students.each do |student|
        @exam.exam_portions.each do |portion|
          unless portion.exam_portion_scores.pluck(:student_id).include?(student.id)
            ExamPortionScore.create!(exam_portion: portion, student: student)
          end
        end
      end
    end

  end
end
