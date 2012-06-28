#= require buhin/buhin-base

class StudentGrid extends BuHin
  students: null
  pageSize: 5
  window:
    width: 800
    height: 600
  position: null
  studentsPerPage: 10

  defColWidth: 128

  _createGrid: () ->
    gridArgs =
      dataSource:
        data: @students
        pageSize: @studentsPerPage
      height: (@studentsPerPage + 1) * 36
      groupable: true
      scrollable: false
      sortable: true
      pageable: true
      resizable: true
      reorderable: true
      columns: [
        {
          field: "name"
          title: 'students.name' #これをt("students.name")にしたい。
          width: 128
        },{
          field: "gender"
          title: "students.gender"
          width: 64
        }]
    
    @target.kendoGrid(gridArgs)

  refreshGrid: (query) ->
    $.getJSON query, (studentData) =>
      if studentData == null
        return

      @students = studentData

      i = 0
      while i < @students.length
        pop = "<a href=\"#\" class=\"btn btn-danger\" rel=\"popover\" title=\"A Title\" data-content=\"test\">hover for popover</a>"
        tag = "<div style=\"float:left\"><a class=\"k-button\" href=\"/students/" + @students[i].id + "\">表示</a><a class=\"k-button\" href=\"/students/" + @students[i].id + "/edit\">編集</a></div>"
        @students[i]["manage"] = pop
        i++

        @_createGrid()

  _getScreenMetrics: () ->
    @window.height = $(window).height()
    @position = @target.position()
    @studentsPerPage = Math.round((@window.height - @position.top) / 36) - 2

  init: () ->
    @_getScreenMetrics()
    @refreshGrid("/students.json")

  ProcessOptions: (options) ->
    

$.fn.studentGrid = (options) ->
  pluginName = 'studentGrid'
  @.each ->
    if !$.data(@, "plugin_#{pluginName}")
      $.data(@, "plugin_#{pluginName}", new StudentGrid(@))

    $.data(@, "plugin_#{pluginName}").ProcessOptions(options)

  return @
