# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->

  #student
  $('#new-student-form form').validationEngine()

  $('#new-student-link').on 'click', (event) ->
    event.preventDefault()
    $('#new-student-form').slideToggle()

  $("#cancel-student-link").click ->
    $("#new-student-link").show()
    $("#new-student-form").slideToggle()

  $('#delete-student-link').on 'click', (e)->
    e.preventDefault()
    $('#delete-modal').modal('show')

  $('.js-autocomplete').each (i, element) ->
    element_id = '#' + $(element).attr('id')
    $(element_id).autocomplete
      source: $(element_id).data('autocomplete-source')
      select: (event, ui) ->
        $(this).val(ui.item.value);
        $.get($("#search-students").attr("action"), $("#search-students").serialize(), null, "script");
      
      
  $("#students-index th a").live 'click', (event) ->
    $.getScript(this.href)
    return false

  $("#search-students input").on 'keyup', (event) ->
    $.get($("#search-students").attr("action"), $("#search-students").serialize(), null, "script")
    return false

  $("#search-students select").on 'change', (event) ->
    $.get($("#search-students").attr("action"), $("#search-students").serialize(), null, "script")
    return false

  $("#upload-student-picture-link").click ->
    $("#upload-student-picture").toggle()

    
  $('.datepicker').datepicker(format:'yyyy/mm/dd')
  $(".class-group-select").combobox()