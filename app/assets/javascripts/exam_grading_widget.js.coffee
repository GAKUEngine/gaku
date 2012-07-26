#= require buhin/buhin-base

class ExamGradingWidget extends BuHin
  controlBar:
    element: null
    buttonGroups: null

  _addButtonGroup: (target, id, title, iconClasses) ->
    newGroup = $("<div></div>")
    newGroup.attr("id", id)
    newGroup.addClass("well span3")
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
    @controlBar.element.addClass("row-fluid span12 btn-toolbar")
    @buttonGroups = []

    studentOrder = @_addButtonGroup(@controlBar.element, "student_order", "Student Order", "icon-list-alt icon-black")
    @_addButtonToGroup(studentOrder.group, "seat_number", "出席番号", null, true)
    @_addButtonToGroup(studentOrder.group, "exam_points", "考査得点順", null, false)
    @_addButtonToGroup(studentOrder.group, "term_points", "学期得点順", null, false)

    processingStatusSort = @_addButtonGroup(@controlBar.element, "processing_status_sort", "Processing Status", "icon_edit icon-black")
    @_addButtonToGroup(processingStatusSort.group, "processing_all", "全件", null, true)
    @_addButtonToGroup(processingStatusSort.group, "processing_unscored", "未入力", null)
    @_addButtonToGroup(processingStatusSort.group, "processing_partial", "入力途中", null)
    @_addButtonToGroup(processingStatusSort.group, "processing_completed", "入力完了", null)

    toolbox = @_addButtonGroup(@controlBar.element, "exam_toolbox", "Tools", "icon-wrench icon-black")
    @_addButton(toolbox, "auto_score", "AutoScore", null)
    @_addButton(toolbox, "auto_grade", "AutoGrade", null)
    @_addButton(toolbox, "auto_rank", "AutoRank", null)
    @_addButton(toolbox, "view_scales", "View Scales", null)


    @controlBar.element.appendTo(@target)

  init: () ->
    if @target == null
      return

    @target.addClass("well")
    @createControlBar()

    #@target.append(@controlBar)

    
    

$.fn.examGradingWidget = (options) ->
  pluginName = 'examGradingWidget'
  @.each ->
    if !$.data(@, "plugin_#{pluginName}")
      $.data(@, "plugin_#{pluginName}", new ExamGradingWidget(@))

    $.data(@, "plugin_#{pluginName}").ProcessOptions(options)

  return @
