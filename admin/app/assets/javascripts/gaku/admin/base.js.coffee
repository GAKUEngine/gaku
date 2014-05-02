window.showNotice = (notice)->
  $('#notice').html(notice).delay(3000).fadeOut ->
    $(@).html('').show()

$.fn.enableValidations = ->
  $(this).enableRails4ClientSideValidations()

$.fn.withAnimation = ->
  $(this).animate({height:"toggle", opacity:"toggle"})

$.fn.showModal = ->
  $(this).modal('show')

$.fn.hideModal = ->
  $(this).modal('hide')

$.fn.datepicker_i18n = ->
  $(this).datepicker({
       language: $('body').data('locale'),
       startView: 2,
       autoclose: true,
       todayBtn: true,
       todayHighlight: true,
       calendarWeeks: true
  })

$.fn.datepicker.defaults.format = "yyyy-mm-dd"

window.load_states = ->
  countryCode = $("#country_dropdown option:selected").val()
  if countryCode
    $.ajax
      type: 'get'
      url: '/states'
      dataType: 'script'
      data:
        country_id: countryCode

ready = ->

  class Admin
    init: ->
      $('.datepicker').datepicker_i18n()

      $(document).on 'ajax:success', '.recovery-link', ->
        $(this).closest('tr').remove()

      $(document).on 'ajax:success','.delete-link', (evt, data, status, xhr) ->
        $(this).closest('tr').remove()

      notice = $('#notice')
      if notice.children().length > 0
        notice.children().delay(3000).fadeOut ->
          notice.html('')

      $('.modal-delete-link').on 'click', (e)->
        e.preventDefault()
        $('#delete-modal').modal('show')


      $('.sortable').sortable
        handle: '.sort-handler'
        helper: fixHelper
        axis: 'y'
        update: ->
          $.post $(@).data('sort-url'), $(@).sortable('serialize')

      # sorting
      fixHelper = (e, ui) ->
        ui.children().each ->
          $(@).width $(@).width()
        ui

    edit: ->
      @upload_picture()

      unless(typeof notable_resource == 'undefined')
        $("#submit-" + notable_resource + "-note-button").live "ajax:success", (data, status, xhr)->
          $("#new-" + notable_resource + "-note-link").show()
          $("#new-" + notable_resource + "-note form").slide()

      $('#soft-delete-link').on 'click', (e)->
        e.preventDefault()
        $('#delete-modal').modal('show')

    show: ->
      # FIXME Remove after view refactoring
      @edit()

    upload_picture: ->
      $(document).on 'click', '#upload-picture-link', ->
        $("#upload-picture").toggle()

    upload_picture_ajax: ->
      $('body').popover
        selector: '.picture-upload'
        html: true
        content: ()->
          return $('#upload-picture').html()
        placement: 'bottom'
        trigger: 'click'

    country_dropdown: ->
      $('body').on 'change', '#country_dropdown', ->
        window.load_states()


  @admin = new Admin

  (($, undefined_) ->
    $ ->
      $body = $("body")
      parent_controller = $body.data("parent-controller")
      action = $body.data("action")

      @admin.init()  if $.isFunction(@admin.init)
      @admin[action]()  if $.isFunction(@admin[action])

      activeController = @admin[parent_controller]
      if activeController isnt `undefined`
        activeController.init()  if $.isFunction(activeController.init)
        activeController[action]()  if $.isFunction(activeController[action])
  ) jQuery


$(document).ready(ready)
$(window).bind('page:change', ready)
