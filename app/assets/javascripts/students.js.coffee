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

  $('#q_name_cont').autocomplete
    source: $('#q_name_cont').data('autocomplete-source')
    select: (event, ui) ->
      $(this).val(ui.item.value);
      $.get($("#search-students").attr("action"), $("#search-students").serialize(), null, "script");
        
  $('#q_surname_cont').autocomplete
    source: $('#q_surname_cont').data('autocomplete-source')
    select: (event, ui) ->
      $(this).val(ui.item.value);
      $.get($("#search-students").attr("action"), $("#search-students").serialize(), null, "script");

  $('#q_addresses_title_cont').autocomplete
    source: $('#q_addresses_title_cont').data('autocomplete-source')
    select: (event, ui) ->
      $(this).val(ui.item.value);
      $.get($("#student_search").attr("action"), $("#student_search").serialize(), null, "script");
      
  $("#students-index th a").live 'click', (event) ->
    $.getScript(this.href)
    return false

  $("#search-students input").on 'keyup', (event) ->
    $.get($("#search-students").attr("action"), $("#search-students").serialize(), null, "script")
    return false
