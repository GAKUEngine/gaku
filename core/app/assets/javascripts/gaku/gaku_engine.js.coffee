window.GAKUEngine =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->


$.fn.enableValidations = ->
  $(this).enableRails4ClientSideValidations()

ready = ->

  #console.log 'do_on_change loaded'

  $('#soft-delete-link').on 'click', (e)->
    e.preventDefault()
    $('#delete-modal').modal('show')

  $("#upload-picture-link").click ->
    $("#upload-picture").toggle()

  $('.datepicker').datepicker(format:'yyyy/mm/dd')

  $(document).on 'ajax:success', '.recovery-link', ->
    $(this).closest('tr').remove()


  $(document).on 'ajax:success','.delete-link', (evt, data, status, xhr) ->
    $(this).closest('tr').remove()

  # small plugin for fadeOut notices after 2sec when notice is showed
  window.showNotice = (notice)->
    $('#notice').html(notice).delay(3000).fadeOut ->
      $(@).html('').show()


  $(document).on "click",".cancel-link", (e) ->
    console.log 'Cancel event'
    e.preventDefault()
    resource_id = $(this).attr("id").replace("cancel-", "").replace("-link", "")
    resource_new_link = "#new-" + resource_id + "-link"
    resource_form = "#new-" + resource_id
    $(resource_new_link).show()
    $(resource_form).slideUp()

  $(document).on 'click', '#cancel-student-commute-method-link', (e) ->
    e.preventDefault()
    $('#student-commute-method-form').slideUp ->
      $('#commute-method').show()
      $('#edit-student-commute-method-link').show()

  # sorting
  fixHelper = (e, ui) ->
    ui.children().each ->
      $(@).width $(@).width()
    ui


  $('.sortable').sortable
    handle: '.sort-handler'
    helper: fixHelper
    axis: 'y'
    update: ->
      $.post $(@).data('sort-url'), $(@).sortable('serialize')


$(document).ready(ready)
$(window).bind('page:change', ready)
