# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $('#new-student-address-link').on 'click','a.btn', (event) ->
    event.preventDefault()
    $('#new-student-address-form').slideDown()

  $('#new-student-link').on 'click', (event) ->
    event.preventDefault()
    $('#new-student-form').slideToggle()

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

  $("#cancel-student-link").click ->
    $("#new-student-link").show()
    $("#new-student-form").slideToggle()
