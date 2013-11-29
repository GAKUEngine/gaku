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

      # init variables -------- {
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

      # init variables --------
      @deviation = Hash.new { |hash,key| hash[key] = {} }
      std_dev = 0.0
      scratch_dev = 0.0

      # start calc --------
      @exams.each do |exam|

        # calc standard deviations --------
        @students.each do |student|
          if exam.use_weighting
            std_dev += (@student_total_weights[student.id][exam.id] - @exam_weight_averages[exam.id]) ** 2
          else
            std_dev += (@student_total_scores[student.id][exam.id] - @exam_averages[exam.id]) ** 2
          end
        end

        # calc deviations --------
        std_dev = Math.sqrt std_dev / @students.length
        @students.each do |student|

          # init valiable for deviations --------
          @deviation[student.id][exam.id] = 0.0

          if exam.use_weighting
            scratch_dev = (@student_total_weights[student.id][exam.id] - @exam_weight_averages[exam.id]) / std_dev
          else
            scratch_dev = (@student_total_scores[student.id][exam.id] - @exam_averages[exam.id]) / std_dev
          end

          # set deviations --------
          if scratch_dev.nan?
            @deviation[student.id][exam.id] = 50
          else
            @deviation[student.id][exam.id] = fix_digit scratch_dev * 10 + 50, 4
          end
        end

      end
      # -------- }


      # Grade and Rank Calculation （ここは別途光ヶ丘生徒評価表を参照して下さい）-------- {

      # init variables --------

      # １０段階用の設定
      # @grade: 生徒の１０段階を入れるHash。
      # GRADE_LEVELS_BY_DEVIATION:
      #   １０段階を全体評価で判定する時に使う定数。
      #   決められた偏差値を基に、生徒の偏差値と比べ、その多寡を使って評価を行う。
      # GRADE_LEVELS_BY_PERCENT:
      #   １０段階を相対評価で判定する時に使う定数。
      #   決められたパーセンテージを基に、生徒がクラス内で上位何％以内かを調べ、評価を行う。
      @grades = Hash.new { |hash,key| hash[key] = {} }
      GRADE_LEVELS_BY_DEVIATION = [100, 66, 62, 58, 55, 59, 45, 37, 0]
      GRADE_LEVELS_BY_PERCENT = [5, 5, 10, 10, 30, 10, 100]

      # ５段階用の設定
      # @ranks: 生徒の５段階を入れるHash。
      # RANK_LEVELS: ５段階を付ける時に使うパーセンテージ配列の定数。
      @ranks = Hash.new { |hash,key| hash[key] = {} }
      RANK_LEVELS = [15, 20]

      # set grade and rank --------
      @exams.each do |exam|

        # 生徒の順位用配列を作成（合計点数がDBに入ってるならそれを降順で取れば良いと思う） -------- {
        scores = [] # 生徒の順位を出す為の変数。

        # 試験毎の合計点数と生徒IDをscoresに格納する。
        if exam.use_weighting
          @students.each do |student|
            scores.push [@student_total_weights[student.id][exam.id], student.id]
          end
        else
          @students.each do |student|
            scores.push [@student_total_scores[student.id][exam.id], student.id]
          end
        end
        # 試験のスコアを降順に並び替える
        scores.sort!().reverse!()
        # -------- }

        # 採点方式を選択、その採点方式でGradeとRankを決定。
        grading_method = 1
        grade_point = 10
        case grading_method

        # calc for zentai
        when 1
          GRADE_LEVELS_BY_DEVIATION.each_with_index do |glevel, i|
            @students.each do |student|
              if GRADE_LEVELS_BY_DEVIATION[i] > @deviation[student.id][exam.id] && GRADE_LEVELS_BY_DEVIATION[i+1] <= @deviation[student.id][exam.id]
                @grades[exam.id][student.id] = grade_point
              end
            end
            grade_point -= 1
          end

        # calc for soutai
        when 2
          scoresMem = scores.clone
          gradeNums = []
          GRADE_LEVELS_BY_PERCENT.each do |glevel|
            gradeNums.push((@students.length * (glevel.to_f / 100)).ceil)
          end
          gradeNums.each do |gnum|
            i = 0
            while i < gnum && scoresMem.length != 0
              @grades[exam.id][scoresMem.shift[1]] = grade_point
              i += 1
            end
            grade_point -= 1
          end
        end

        # Rank Calculation -----↓
        rankPoint = 5
        @students.each do |student|
          @ranks[exam.id][student.id] = 3
        end
        rankNums = []
        RANK_LEVELS.each do |rlevel|
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
