# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $('#new-student-address-link').on 'click','a.btn', (event) ->
    event.preventDefault()
    $('#new-student-address-form').slideDown()

  $('#new_student_link').on 'click', (event) ->
    event.preventDefault()
    $('#new_student_form').slideToggle()
      
  $('.delete_student').live 'ajax:success', (evt, data, status, xhr) ->
    $(this).closest('tr').remove();

  $('#q_name_cont').autocomplete
    source: $('#q_name_cont').data('autocomplete-source')
    select: (event, ui) ->
      $(this).val(ui.item.value);
      $.get($("#student_search").attr("action"), $("#student_search").serialize(), null, "script");
        
  $('#q_surname_cont').autocomplete
    source: $('#q_surname_cont').data('autocomplete-source')
    select: (event, ui) ->
      $(this).val(ui.item.value);
      $.get($("#student_search").attr("action"), $("#student_search").serialize(), null, "script");

  $("#students_index th a").live 'click', (event) ->
    $.getScript(this.href)
    return false

  $("#student_search input").on 'keyup', (event) ->
    $.get($("#student_search").attr("action"), $("#student_search").serialize(), null, "script")
    return false
