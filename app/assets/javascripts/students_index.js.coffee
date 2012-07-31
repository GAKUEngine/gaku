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
    surname: "Surname"
    name: "Name"
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
      resizable: false
      reorderable: true
      # columnMenu: true
      columns: [
        {
          field: "surname"
          title: I18n.t('students.surname')
        },{
          field: "name"
          title: I18n.t('students.name')
        },{
          field: "gender"
          title: I18n.t('gender')
        },{
          field: "manage"
          title: I18n.t('manage')
          width: 78
          encoded: false
          resizable: false
          sortable: false
          groupable: false
        }
      ]
    
    @target.kendoGrid(gridArgs)

  _createCheckbox: () ->

    checkString = (check_s) ->
      ths = $("#grid th")
      i = 0
      while i < ths.length
        if $(ths[i]).text() is check_s
          return i + 1
          break
        i++    
           
    checkBoxes = $("<div></div>")
    $.each @titles, (key, value) ->
      if key != "manage"
        checkBox = $('<div class="form-inline" style="float:left; margin-right:20px"><input id="'+key+'" type="checkbox" checked="false""><label class="help-inline" for="'+key+'">'+value+'</label></div>')
        .appendTo(checkBoxes)
    $("#table-checkboxes").html(checkBoxes.html())
        
    $("#table-checkboxes .form-inline").toggle ((e) ->
      num = checkString(e.currentTarget.textContent)
      $(e.currentTarget).find("input").removeAttr('checked')
      console.log 1
      $("#grid table").find("col:nth-child("+num+"), th:nth-child("+num+"), td:nth-child("+num+")").hide()
    ),(e) ->
      num = checkString(e.currentTarget.textContent)
      $(e.currentTarget).find("input").attr('checked','checked')
      console.log 2
      $("#grid table").find("col:nth-child("+num+"), th:nth-child("+num+"), td:nth-child("+num+")").show()


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

        managementButtons = $("<div></div>")
        showButton = $("<a></a>")
          .css("margin-right","5px")
          .addClass("btn btn-mini btn-primary")
          .attr("href", ('/students/' + @students[i].id))
          .html("<i class='icon-white icon-eye-open'></i>")
          .appendTo(managementButtons)
        editButton = $("<a></a>")
          .addClass("btn btn-mini btn-warning")
          .attr("href", ('/students/' + @students[i].id + "/edit"))
          .html("<i class='icon-white icon-pencil'></i>")
          .appendTo(managementButtons)
        
        @students[i]["manage"] = managementButtons.html()
        i++
        
      @_createGrid()
      @_createCheckbox()
  autocompleteRefreshGrid: (query) ->
    $('input.student_search').autocomplete(
        
        select: (event, ui) ->
          $('input.student_search').autocomplete('search',"#{ui.item.surname} #{ui.item.name}")
      

        source: (req, res) =>
          autocompleteSource = $('input.student_search').data('autocomplete-source')
          $.ajax
            data: 
              term: $('input.student_search').val() 
            type: 'get'
            url: autocompleteSource
            dataType: 'json'
            success: (studentData) =>

              res(studentData)
    # $.getJSON query, (studentData) =>
    #   console.log(studentData)
    #   if studentData == null
    #     return
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

                managementButtons = $("<div></div>")
                showButton = $("<a></a>")
                  .css("margin-right","5px")
                  .addClass("btn btn-mini")
                  .attr("href", ('/students/' + @students[i].id))
                  .html("<i class='icon-eye-open'></i>")
                  .appendTo(managementButtons)
                editButton = $("<a></a>")
                  .addClass("btn btn-mini btn-primary")
                  .attr("href", ('/students/' + @students[i].id + "/edit"))
                  .html("<i class='icon-pencil'></i>")
                  .appendTo(managementButtons)
                
                @students[i]["manage"] = managementButtons.html()
                i++
                
              @_createGrid()
              @_createCheckbox()
              # @refreshGrid
              return false
    ).data('autocomplete')._renderItem =  (ul, item)->
      return $("<li></li>")
                .data("item.autocomplete", item)
                .append("<a> #{item.surname} #{item.name} </a>")
                .appendTo( ul )


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

  clearSearch: ->
    $('input.student_search').on 'keyup', (e)=>
      if $('input.student_search').val() == ''
        @refreshGrid("/students.json")


  init: () ->
    @_getFieldNames()
    @_getScreenMetrics()
    @autocompleteRefreshGrid()
    @refreshGrid("/students.json")
    @clearSearch()

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


