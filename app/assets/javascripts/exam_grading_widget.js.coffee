#= require buhin/buhin-base

class ExamGradingWidget extends BuHin
  controlBar:
    element: null
    buttonGroups: null

  grid: null
  course_id: null
  exam: null
  examPortions: null
  data: null

  _addButtonGroup: (target, id, title, iconClasses) ->
    newGroup = $("<div></div>")
    newGroup.attr("id", id)
    newGroup.addClass("well span4")
    newGroup.icon = $("<i></i>")
    newGroup.icon.addClass(iconClasses)
    newGroup.append(newGroup.icon)
    newGroup.append("<b>" + title + "</b><br />")
    newGroup.group = $("<div></div>")
    newGroup.group.addClass("btn-group last")
    newGroup.group.attr("data-toggle", "buttons-radio")
    newGroup.append(newGroup.group)
    @buttonGroups.push(newGroup)
    newGroup.appendTo(target)
    return newGroup

  _addButtonToGroup: (group, id, name, cb, active = false) ->
    newButton = $("<button></button>")
    newButton.attr("id", id)
    newButton.append(name)
    newButton.addClass("btn")
    if active
      newButton.addClass("active")

    newButton.appendTo(group)
    return newButton

  _addButton: (target, id, name, cb) ->
    newButton = $("<button></button>")
    newButton.attr("id", id)
    newButton.append(name)
    newButton.addClass("btn")

    newButton.appendTo(target)
    return newButton

  createControlBar: () ->
    @controlBar.element = $("<div></div>")
    @controlBar.element.addClass("row-fluid")
    @buttonGroups = []

    studentOrder = @_addButtonGroup(@controlBar.element, "student_order", "Student Order", "icon-list-alt")
    @_addButtonToGroup(studentOrder.group, "seat_number", "出席番号", null, true)
    @_addButtonToGroup(studentOrder.group, "exam_points", "考査得点順", null, false)
    @_addButtonToGroup(studentOrder.group, "term_points", "学期得点順", null, false)

    processingStatusSort = @_addButtonGroup(@controlBar.element, "processing_status_sort", "Processing Status", "icon-edit")
    @_addButtonToGroup(processingStatusSort.group, "processing_all", "全件", null, true)
    @_addButtonToGroup(processingStatusSort.group, "processing_unscored", "未入力", null)
    @_addButtonToGroup(processingStatusSort.group, "processing_partial", "入力途中", null)
    @_addButtonToGroup(processingStatusSort.group, "processing_completed", "入力完了", null)

    toolbox = @_addButtonGroup(@controlBar.element, "exam_toolbox", "Tools", "icon-wrench")
    @_addButton(toolbox.group, "auto_score", "AutoScore", null)
    @_addButton(toolbox.group, "auto_grade", "AutoGrade", null)
    @_addButton(toolbox.group, "auto_rank", "AutoRank", null)
    @_addButton(toolbox.group, "view_scales", "View Scales", null)

    @controlBar.element.appendTo(@target)
    return @controlBar

  createGrid: () ->
    @grid = $("<div></div>")

    column_data = [
      {
        field: "student_id",
        title: I18n.t("students.id"),
        editable: false
      },{
        field: "surname",
        title: I18n.t('students.surname'),
        editable: false
      },{
        field: "name",
        title: I18n.t('students.name'),
        editable: false
      }
    ]

    fields_data = {
      student_id: 'student_id'
      surname: 'surname'
      name: 'name'
    }


    for portion in @examPortions
      do (portion) =>
        portion_id = "portion" + portion.id + ""
        column_data.push({field: "scores[0].score", title: @exam.name + "[" + portion.name + "]", editable: true})
        fields_data["score"] = "name"


    @grid.kendoGrid({
      dataSource: {
        transport: {
          read: "/courses/" + @course_id + "/exams/" + @exam.id + "/exam_portion_scores.json"
        }
      },
      columns: column_data,
      editable: true,
      schema: {
        type: 'json'
        model: {
          fields: fields_data
        }
      }
    })
    @grid.appendTo(@target)

  init: (options) ->
    if @target == null
      return

    @ProcessOptions(options)
    
    @target.addClass("well")
    @createControlBar()
    @createGrid()

    #@target.append(@controlBar)

  ProcessOptions: (options) ->
    if options["course_id"]
      @course_id = options["course_id"]

    #TODO: add filtering by class
    
    if options["exam_data"]
      @exam = options["exam_data"]

    if options["exam_portions_data"]
      @examPortions = options["exam_portions_data"]
$.fn.examGradingWidget = (options) ->
  pluginName = 'examGradingWidget'
  @.each ->
    if !$.data(@, "plugin_#{pluginName}")
      $.data(@, "plugin_#{pluginName}", new ExamGradingWidget(@, options))
    else
      $.data(@, "plugin_#{pluginName}").ProcessOptions(options)

  return @
