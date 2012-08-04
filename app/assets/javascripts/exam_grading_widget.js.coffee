#= require buhin/buhin-base

class StudentScoreSet
  id: null
  name: null
  classGroup: null
  seatNumber: null
  exams: null

  constructor: (id, name, classGroup, seatNumber) ->
    @id = id
    @name = name
    @classGroup = classGroup
    @seatNumber = seatNumber
    @exams = []
    alert "added student: " + @name

  AddExam: (exam) ->
    @exams.push(exam)
  

class ExamGradingWidget extends BuHin
  controlBar:
    element: null
    buttonGroups: null

  rows: null

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
  
  registerRows: (cellIdentifier) ->
    @rows = @target.find(".data_row")
    for row in @rows
      rowElement = $(row)
      studentID = ""
      name = ""
      classGroup = ""
      seatNumber = ""
      cells = rowElement.find("td")
      scoreElements = []
      for cell in cells
        cellElement = $(cell)
        id = cellElement.attr("id")

        if id == "name"
          name = cellElement.html()
        else if id == "class_group"
          classGroup = cellElement.html()
        else if id == "seat_numer"
          seatNumber = cellElement.html()
        else if id == "score"
          scoreElements.push(cellElement)

      scoreSet = new StudentScoreSet(0, name, classGroup, seatNumber)
      # @cells =  $(cellIdentifier)
      # for cell in @cells
      #   element = $(
      #   alert "attaching to: " + cell.attr("id")
      #   cell.blur( ->
      #     $(this).closest("form").submit()
      #   )
      #   #alert cell.attr("student_id")

  init: (options) ->
    if @target == null
      return

    @registerRows()

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
