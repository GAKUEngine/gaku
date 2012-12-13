window.GAKUEngine =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->


window.ClientSideValidations.formBuilders["ValidateFormBuilder"] =
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



$.fn.enableValidations = ->
  $(this).enableClientSideValidations()

$ ->

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
