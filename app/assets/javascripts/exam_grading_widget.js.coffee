#= require buhin/buhin-base

class ExamPortion
  exam: null
  info: null
  id: null
  cell: null
  element: null
  weighting: null

  constructor: (@exam, info, scoreElement) ->
    id = info.attr("exam_portion_id")
    cell = scoreElement
    @element = scoreElement.find("#exam_portion_score_score")
    @element.blur( =>
      @element.closest("form").submit()
      @exam.CalculateTotal()
    )
    
class Exam
  id: null
  portions: null
  totalElement: null
  weightedElement: null
  gradeElement: null
  rankElement: null
  total: 0
  weightedScore: 0

  constructor: (@id) ->
    @portions = []

  CalculateTotal: () ->
    @total = 0
    for portion in @portions
      @total += parseFloat(portion.element.val())


    @totalElement.html(@total)
    @CalculateWeightedScore()

  CalculateWeightedScore: () ->
    @weightedScore = 0
    for portion in @portions
      @weightedScore += parseFloat(portion.element.val()) * (parseFloat(portion.element.attr("weight")) / 100)

    alert @weightedScore
    @weightedElement.html(@weightedScore)

  CalculateGrade: () ->
    console.log average_score
    base_score

  SetTotalTarget: (@totalElement) ->
    @totalElement.html("--")
  SetWeightedTarget: (@weightedElement) ->
    @weightedElement.html("--")
  SetGradeTarget: (@gradeElement) ->
    @gradeElement.html("--")
  SetRankTarget: (@rankElement) ->
    @rankElement.html("--")

  AddScoreElement: (info, scoreElement) ->
    portion = new ExamPortion(@, info, scoreElement)
    @portions.push(portion)
    

class StudentScoreSet
  info: null
  id: null
  name: null
  classGroup: null
  seatNumber: null
  exams: null
  rowElement: null

  parseTableRow: () ->
    weightedTargets = []
    gradeTargets = []
    rankTargets = []
    @scoreSets = []
    cells = @rowElement.find("td")
    for cell in cells
      cellElement = $(cell)
      id = cellElement.attr("id")

      #in general these are processed "in order" from the table
      if id == "name"
        @name = cellElement.html()
        @info = cellElement.find("#student_info")
        @id = @info.attr("student_id")
      else if id == "class_group"
        @classGroup = cellElement.html()
      else if id == "seat_numer"
        @seatNumber = cellElement.html()
      else if id == "score"
        @AddScoreElement(cellElement)
      else if id == "total_points"
        @SetTotalTarget(cellElement)
      else if id == "weighted_score"
        @SetWeightedTarget(cellElement)
      else if id == "grade"
        @SetGradeTarget(cellElement)
      else if id == "rank"
        @SetRankTarget(cellElement)

    #calculate totals for all added exams in all added score sets
    @CalculateTotals()

  constructor: (rowElement) ->
    @rowElement = rowElement
    @exams = []
    @scoreElements = []

    @parseTableRow()

  addExamAndPortion: (examId, portionId) ->
    for exam in @exams
      if exam.id == examID
        exam.AddPortion(portionId)
        reutrn

    newExam = new Exam(examId)
    newExam.AddPortion(portionId)
    @exams.push(newExam)

  SetTotalTarget: (target) ->
    examId = target.attr("exam_id")
    for exam in @exams
      if exam.id == examId
        exam.SetTotalTarget(target)
        return
  SetWeightedTarget: (target) ->
    examId = target.attr("exam_id")
    for exam in @exams
      if exam.id == examId
        exam.SetWeightedTarget(target)
        return
  SetGradeTarget: (target) ->
    examId = target.attr("exam_id")
    for exam in @exams
      if exam.id == examId
        exam.SetGradeTarget(target)
        return
  SetRankTarget: (target) ->
    examId = target.attr("exam_id")
    for exam in @exams
      if exam.id == examId
        exam.SetRankTarget(target)
        return

  AddScoreElement: (scoreElement) ->
    #get data
    info = scoreElement.find("#score_info")
    #find what exam this element belongs to
    examId = info.attr("exam_id")
    for exam in @exams
      if exam.id == examId
        #add it
        exam.AddScoreElement(info, scoreElement)
        return
    
    #no exams were found with that ID, create a new one
    exam = new Exam(examId)
    exam.AddScoreElement(info, scoreElement)
    @exams.push(exam)

  CalculateTotals: () ->
    count = 0
    for exam in @exams
      exam.CalculateTotal()

class ExamInfo
  id: 0
  name: null
  average: 0
  totalScore: 0
  numStudents: 0

  constructor: (@id, @name) ->
    @Clear()

  CalculateAverage: (scoreSet) ->
    # weighted_scores = $(".weighted_scores")
    # i = 0
    # while i < weighted_scores.length
    #   calculate_value += parseFloat($(weighted_scores[i]).text())
    #   i++
    # 
    # average_score = calculate_value / weighted_scores.length
    # console.log average_score

  Clear: () ->
    @average = 0
    @totalScore = 0
    @numStudents = 0

  AddScore: (score) ->
    totalScore += score
    numStudents += 1

class ExamInfoManager
  exams: null

  constructor: () ->
    @exams = []

  AddExamInfo: (id, name)
    @exams.push(new ExamInfo(id, name))

  CalculateExamTotals: (scoreSets) ->
    for exam in @exams
      exam.Clear()

    #ここに各試験の合計点を割り出す
    studentIdx = 0
    for set in scoreSets
      examIdx = 0
      for exam in @exams
        #ここにexamごとのコレクションを作って合計を計算して貰う
        @exams.exam[examIdx].AddScore(set.exams[examIdx].total)
        examIdx += 1
      studentIdx += 1

  CalculateAverages: (scoreSets) ->


        

class ExamGradingWidget extends BuHin
  controlBar:
    element: null
    buttonGroups: null

  rows: null
  scoreSets: null
  examInfo: null

  #  _addButtonGroup: (target, id, title, iconClasses) ->
  #    newGroup = $("<div></div>")
  #    newGroup.attr("id", id)
  #    newGroup.addClass("well span4")
  #    newGroup.icon = $("<i></i>")
  #    newGroup.icon.addClass(iconClasses)
  #    newGroup.append(newGroup.icon)
  #    newGroup.append("<b>" + title + "</b><br />")
  #    newGroup.group = $("<div></div>")
  #    newGroup.group.addClass("btn-group last")
  #    newGroup.group.attr("data-toggle", "buttons-radio")
  #    newGroup.append(newGroup.group)
  #    @buttonGroups.push(newGroup)
  #    newGroup.appendTo(target)
  #    return newGroup
  #
  #  _addButtonToGroup: (group, id, name, cb, active = false) ->
  #    newButton = $("<button></button>")
  #    newButton.attr("id", id)
  #    newButton.append(name)
  #    newButton.addClass("btn")
  #    if active
  #      newButton.addClass("active")
  #
  #    newButton.appendTo(group)
  #    return newButton
  #
  #  _addButton: (target, id, name, cb) ->
  #    newButton = $("<button></button>")
  #    newButton.attr("id", id)
  #    newButton.append(name)
  #    newButton.addClass("btn")
  #
  #    newButton.appendTo(target)
  #    return newButton
  #
  #  createControlBar: () ->
  #    @controlBar.element = $("<div></div>")
  #    @controlBar.element.addClass("row-fluid")
  #    @buttonGroups = []
  #
  #    studentOrder = @_addButtonGroup(@controlBar.element, "student_order", "Student Order", "icon-list-alt")
  #    @_addButtonToGroup(studentOrder.group, "seat_number", "出席番号", null, true)
  #    @_addButtonToGroup(studentOrder.group, "exam_points", "考査得点順", null, false)
  #    @_addButtonToGroup(studentOrder.group, "term_points", "学期得点順", null, false)
  #
  #    processingStatusSort = @_addButtonGroup(@controlBar.element, "processing_status_sort", "Processing Status", "icon-edit")
  #    @_addButtonToGroup(processingStatusSort.group, "processing_all", "全件", null, true)
  #    @_addButtonToGroup(processingStatusSort.group, "processing_unscored", "未入力", null)
  #    @_addButtonToGroup(processingStatusSort.group, "processing_partial", "入力途中", null)
  #    @_addButtonToGroup(processingStatusSort.group, "processing_completed", "入力完了", null)
  #
  #    toolbox = @_addButtonGroup(@controlBar.element, "exam_toolbox", "Tools", "icon-wrench")
  #    @_addButton(toolbox.group, "auto_score", "AutoScore", null)
  #    @_addButton(toolbox.group, "auto_grade", "AutoGrade", null)
  #    @_addButton(toolbox.group, "auto_rank", "AutoRank", null)
  #    @_addButton(toolbox.group, "view_scales", "View Scales", null)
  #
  #    @controlBar.element.appendTo(@target)
  #    return @controlBar
  
  registerExams: () ->
    @examInfo = new ExamInfoManager()

    #ここで各試験の情報をテーブルから取得し@examInfo.AddExamInfo(id, name)で追加


  registerRows: () ->
    @scoreSets = []
    @rows = @target.find(".data_row")
    for row in @rows
      #create a new student score set for this row
      scoreSet = new StudentScoreSet($(row))
      @scoreSets.push(scoreSet)

  init: (options) ->
    if @target == null
      return

    @registerExams()
    @registerRows()
    @examInfo.CalculateExamTotals()
    @examInfo.CalculateAverages()

    #@createControlBar()
    #@target.append(@controlBar)

  ProcessOptions: (options) ->

$.fn.examGradingWidget = (options) ->
   pluginName = 'examGradingWidget'
   @.each ->
     if !$.data(@, "plugin_#{pluginName}")
       $.data(@, "plugin_#{pluginName}", new ExamGradingWidget(@, options))
     else
       $.data(@, "plugin_#{pluginName}").ProcessOptions(options)

  return @
