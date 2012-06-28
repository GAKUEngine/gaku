#= require buhin/buhin-base

class StudentGrid extends BuHin
  students: null
  pageSize: 5
  window:
    width: 800
    height: 600
  position: null
  studentsPerPage: 10
  titles:
    name: "Name"
    surname: "Surname"
    gender: "Gender"

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
          field: "surname"
          title: @titles.surname
          width: 128
        },{
          field: "name"
          title: @titles.name
          width: 128
        },{
          field: "gender"
          title: @titles.gender
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

  _getFieldNames: () ->
    fields = $("#fields").find('*[data-field]')
    for field in fields
      fieldObj = $(field)
      @titles[fieldObj.attr('data-field')] = fieldObj.html()


  _getScreenMetrics: () ->
    @window.height = $(window).height()
    @position = @target.position()
    @studentsPerPage = Math.round((@window.height - @position.top) / 36) - 2

  init: () ->
    @_getFieldNames()
    @_getScreenMetrics()
    @refreshGrid("/students.json")

  ProcessOptions: (options) ->
    if options
      if options["titles"]
        @titles = options["titles"]
        @_createGrid() #本当はタイトルだけ置き換えると良いけど

$.fn.studentGrid = (options) ->
  pluginName = 'studentGrid'
  @.each ->
    if !$.data(@, "plugin_#{pluginName}")
      $.data(@, "plugin_#{pluginName}", new StudentGrid(@))

    $.data(@, "plugin_#{pluginName}").ProcessOptions(options)

  return @
