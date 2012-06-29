#= require buhin/buhin-base

class StudentGrid extends BuHin
  students: null
  pageSize: 5
  window:
    width: 800
    height: 600
  position: null
  studentsPerPage: 10
  fields: null
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
        },{
          field: "manage"
          title: @titles.manage
          width: 64
          encoded: false
        }]
    
    @target.kendoGrid(gridArgs)

  refreshGrid: (query) ->
    $.getJSON query, (studentData) =>
      if studentData == null
        return

      @students = studentData

      i = 0
      while i < @students.length
        manage = $("<div></div>")
        pop = $("<a></a>")
        pop.attr("href", "#")
          .addClass("btn btn-danger")
          .attr("rel", "popover")
          .attr("title", "edit")
          .attr("data-content", "edit")
          .html("hover for popover")

        editButton = $("<a></a>")
          .addClass("btn")
          .attr("href", ('/students/' + @students[i].id))
          .html("編集")
        @students[i]["manage"] = editButton.wrap("<div></div>").parent().html()
        i++

      @_createGrid()

  _getFieldNames: () ->
    @fields = $("#fields")
    fieldItems = @fields.find('*[data-field]')
    for field in fieldItems
      fieldObj = $(field)
      @titles[fieldObj.attr('data-field')] = fieldObj.html()

    @fields.css("display", "none")


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
