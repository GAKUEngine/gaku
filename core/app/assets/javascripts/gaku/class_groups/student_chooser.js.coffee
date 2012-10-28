#= require buhin/buhin-base

class StudentChooser extends BuHin
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
    class_group: "Class Group"
    seat_number: "Seat Number"
    addmited: "Admitted"
    primary_address: "Primary Address"

  defColWidth: 128

  _columns: () ->
    switch $('#student_grid').data('select-mode')
      when 'multiple'
        return [
                {
                  field: 'checkbox'
                  title: "Select"
                  encoded: false
                  width: 5
                },{
                  field: "surname"
                  title: I18n.t('students.surname')
                },{
                  field: "name"
                  title: I18n.t('students.name')
                },{
                  field: "gender"
                  title: I18n.t('gender')
                },{
                  field: "class_group_widget"
                  title: "Class Group"
                  groupable: true
                },{
                  field: "seat_number_widget"
                  title: "Seat Number"
                  sortable: true
                },{
                  field: "admitted"
                  title: "Admitted"
                  groupable: true
                  sortable: true
                },{
                  field: "address_widget"
                  title: "Primary Address"
                  groupable: true
                  sortable: true
                }]
      when 'single'
        return [{
                  field: "surname"
                  title: I18n.t('students.surname')
                },{
                  field: "name"
                  title: I18n.t('students.name')
                },{
                  field: "gender"
                  title: I18n.t('gender')
                },{
                  field: "class_group_widget"
                  title: "Class Group"
                  groupable: true
                },{
                  field: "seat_number_widget"
                  title: "Seat Number"
                  sortable: true
                },{
                  field: "admitted"
                  title: "Admitted"
                  groupable: true
                  sortable: true
                },{
                  field: "address_widget"
                  title: "Primary Address"
                  groupable: true
                  sortable: true
                }]

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
      columns: @_columns()
    
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
      if key != "manage" and key != 'checkbox'
        checkBox = $('<div class="form-inline" style="float:left; margin-right:20px"><input id="'+key+'" type="checkbox" checked="false""><label class="help-inline" for="'+key+'">'+value+'</label></div>')
        .appendTo(checkBoxes)
    $("#table-checkboxes").html(checkBoxes.html())
        
    $("#table-checkboxes .form-inline").toggle ((e) ->
      num = checkString(e.currentTarget.textContent)
      $(e.currentTarget).find("input").removeAttr('checked')
      $("#grid table").find("col:nth-child("+num+"), th:nth-child("+num+"), td:nth-child("+num+")").hide()
    ),(e) ->
      num = checkString(e.currentTarget.textContent)
      $(e.currentTarget).find("input").attr('checked','checked')
      $("#grid table").find("col:nth-child("+num+"), th:nth-child("+num+"), td:nth-child("+num+")").show()

  _manageCheckBox: (@students) ->
    i = 0
    while i < @students.length
      # create checkbox for student row
      checkbox = $("<div></div>")
      showButton = $("<input type='checkbox' class='student_check' id='" + @students[i].id + "' value='" + @students[i].id + "'></input>")
        .css("margin-left","10px")
        .appendTo(checkbox)

      @students[i]["checkbox"] = checkbox.html()
      i++
  _manageButtons: (@students) ->
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
        .addClass("btn btn-mini btn-success")
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
  refreshGrid: (query) ->
    $.getJSON query, (studentData) =>
      if studentData == null
        return
      
      @students = studentData

      @_manageButtons(@students)
      @_manageCheckBox(@students)
        
      @_createCheckbox()
      @_createGrid()
      
  autocompleteRefreshGrid: (query) ->
    $('input.student_search').autocomplete(
        
        select: (event, ui) ->
          $('input.student_search').autocomplete('search',"#{ui.item.surname} #{ui.item.name}")
      

        source: (req, res) =>
          autocompleteSource = $('input.student_search').data('autocomplete-source')
          $.ajax
            data:
              term: $('input.student_search').val()
              class_group_id: window.location.pathname.split('/')[2]
            type: 'get'
            url: autocompleteSource
            dataType: 'json'
            success: (studentData) =>

              res(studentData)
    
              if studentData == null
                return

              @students = studentData

              @_manageButtons(@students)
              @_manageCheckBox(@students)

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
        @refreshGrid(@requestPath())

  requestPath: ->
    classGroupId = window.location.pathname.split('/')[2]
    return "/class_group_enrollments/filtered_students.json?class_group_id=" + classGroupId

  init: () ->
    #console.log(@requestPath())
    @_getFieldNames()
    @_getScreenMetrics()
    @autocompleteRefreshGrid()
    @refreshGrid(@requestPath())
    @clearSearch()

  ProcessOptions: (options) ->
    if options
      if options["titles"]
        @titles = options["titles"]
        @_createGrid() #本当はタイトルだけ置き換えると良いけど

$.fn.studentChooser = (options) ->
  pluginName = 'studentChooser'
  @.each ->
    if !$.data(@, "plugin_#{pluginName}")
      $.data(@, "plugin_#{pluginName}", new StudentChooser(@))

    $.data(@, "plugin_#{pluginName}").ProcessOptions(options)

  return @


