window.GAKUEngine =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->

formBuilder =
  add: (element, settings, message) ->
    if element.data("valid") isnt false
      element.data "valid", false
      element.parent().parent().addClass "error"
      element.parent().find(".message").addClass "error help-inline"
      $('<span/>').addClass('help-inline').text(message).appendTo(element.parent())

  remove: (element, settings) ->
    element.parent().parent().removeClass('error')
    element.parent().find(".message").removeClass "error help-inline"
    element.parent().find('span.help-inline').remove()
    element.data "valid", true



window.ClientSideValidations.formBuilders["ValidateFormBuilder"] = formBuilder

window.ClientSideValidations.formBuilders["ValidateNestedFormBuilder"] = formBuilder

$.fn.inline_select = (resource) ->
  console.log resource
  $(this).editable
    source: resource
    showbuttons: false
    display: (value, sourceData) ->
      html = []
      checked = $.fn.editableutils.itemsByValue(value, sourceData)
      if checked.length
        $.each checked, (i, v) ->
          html.push $.fn.editableutils.escape(v.text)

        $(this).html html.join(", ")
      else
        $(this).empty()
      $(this).show()

$.fn.inline_date = () ->
  $(this).editable
    display: (value) ->
      $(this).show()
      console.log moment(value)


$.fn.enableValidations = ->
  $(this).enableClientSideValidations()


$.fn.editable.defaults.mode = 'inline'

$ ->

  $('#sof-delete-link').on 'click', (e)->
    e.preventDefault()
    $('#delete-modal').modal('show')

  $("#upload-picture-link").click ->
    $("#upload-picture").toggle()

  $('.datepicker').datepicker(format:'yyyy/mm/dd')


  $(document).on 'ajax:success','.delete-link', (evt, data, status, xhr) ->
    $(this).closest('tr').remove()

  # small plugin for fadeOut notices after 2sec when notice is showed
  window.showNotice = (notice)->
    $('#notice').html(notice).delay(3000).fadeOut ->
      $(@).html('').show()

  window.ClientSideValidations.callbacks.element.fail = (element, message, callback) ->
    callback()
    if element.data("valid") isnt false
      element.parent().parent().addClass "error"
      element.parent().find(".message").addClass "error help-inline"



  $(document).on "click",".cancel-link", (e) ->
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
