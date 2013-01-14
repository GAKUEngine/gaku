response.headers["Content-Disposition"] = "attachment; filename='#{@course.code}.xls'"

students = @course.students

book = Spreadsheet::Workbook.new
summary_sheet = book.create_worksheet
summary_sheet.name = 'Exam Summary Sheet'
exams = @course.syllabus.exams
exams.each do |exam|

  #dynamicly merging cells
  exam_portion_count = exam.exam_portions.count

  #create worksheet for current exam
  exam_sheet = book.create_worksheet :name => exam.name

  # formating and merging cells
  format = Spreadsheet::Format.new :weight => :bold, :align => :center
  exam_sheet.row(0).default_format = format
  exam_sheet.row(1).default_format = format
  exam_sheet.row(2).default_format = format

  exam_sheet.merge_cells(1,0,1,3)
  exam_sheet.merge_cells(1,4,1,3 + exam_portion_count)


  #first info row
  exam_sheet.row(0)[0] = 'Course Code:'
  exam_sheet.row(0)[1] = @course.code
  exam_sheet.row(0)[2] = 'Course ID:'
  exam_sheet.row(0)[3] = @course.id
  exam_sheet.row(0)[4] = 'Exam Name:'
  exam_sheet.row(0)[5] = exam.name
  exam_sheet.row(0)[6] = 'Exam ID:'
  exam_sheet.row(0)[7] = exam.id

  # table header cells
  exam_sheet.row(1).concat ['Student','','','', "#{exam.name}"]
  exam_sheet.row(2).concat ['id','Class', 'Seat Number','Name']
  exam.exam_portions.each_with_index do |portion, index|
    exam_sheet.row(2)[4 + index] = portion.name
  end

  #students info section
  students.each_with_index do |student, index|
    exam_sheet.row(3 + index)[0] = student.id
    # exam_sheet.row(2 + index)[0] = ?  - class
    # exam_sheet.row(2 + index)[1] = ?  - seat number
    exam_sheet.row(3 + index)[3] = student

    # studens/exam_portion score matrix
    exam.exam_portions.each_with_index do |portion, portion_index|

      #this method should be improved. many queries to db
      portion_score = student.exam_portion_scores.where(:exam_portion_id => portion.id).first

      exam_sheet.row(3 + index)[(4 + portion_index.to_i)] = portion_score.score rescue ''
    end
  end
end

spreadsheet = StringIO.new
book.write spreadsheet
spreadsheet.string
