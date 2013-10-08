window.GAKUEngine =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  resources: {}
  init: ->

window.showNotice = (notice)->
  $('#notice').html(notice).delay(3000).fadeOut ->
    $(@).html('').show()

$.fn.enableValidations = ->
  $(this).enableRails4ClientSideValidations()


window.load_states = ->
  console.log "Load states executed"
  countryCode = $("#country_dropdown option:selected").val()
  if countryCode
    $.ajax
      type: 'get'
      url: '/states'
      dataType: 'script'
      data:
        country_id: countryCode

ready = ->

  class App
    init: ->
      $(document).off('click', '.cancel-link').on "click",".cancel-link", (e) ->
        e.preventDefault()
        if $(e.target).parents('.modal-body').length == 0
          resource_id = $(this).attr("id").replace("cancel-", "").replace("-link", "")
          resource_new_link = "#new-" + resource_id + "-link"
          resource_form = "#new-" + resource_id
          $(resource_new_link).show()
          $(resource_form).slide()

      $(document).on 'ajax:success', '.recovery-link', ->
        $(this).closest('tr').remove()

      $(document).on 'ajax:success','.delete-link', (evt, data, status, xhr) ->
        $(this).closest('tr').remove()

      notice = $('#notice')
      if notice.children().length > 0
        notice.children().delay(3000).fadeOut ->
          notice.html('')


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

      $('.datepicker').datepicker(format:'yyyy/mm/dd')

    show: ->
      # FIXME Remove after view refactoring
      @edit()

    upload_picture: ->
      $("#upload-picture-link").click ->
        $("#upload-picture").toggle()

    country_dropdown: ->
      $('body').on 'change', '#country_dropdown', ->
        window.load_states()

    student_chooser: ->
      $(document).on 'keydown', '.js-autocomplete', (event) ->
        element_id = '#' + $(this).attr('id')
        $(element_id).autocomplete
          source: $(element_id).data('autocomplete-source')
          messages:
            noResults: ->
            results: ->
          select: (event, ui) ->
            $(this).val(ui.item.value);
            $.get($("#search-students").attr("action"), $("#search-students").serialize(), null, "script");

      $(document).on 'click', "#students-index th a", (event) ->
        $.getScript(this.href)
        return false

      $(document).on 'keyup', "#search-students input", (event) ->
        $.get($("#search-students").attr("action"), $("#search-students").serialize(), null, "script")
        return false

      $(document).on 'change', "#search-students select", (event) ->
        $.get($("#search-students").attr("action"), $("#search-students").serialize(), null, "script")
        return false


      $('body').on 'change', 'input.student-check', ->
        thisCheck = $(this)
        thisId = $(this).closest('tr').attr('id')

        if thisCheck.is (':checked')
          surname = $(this).closest('tr').find('td.surname').text()
          name = $(this).closest('tr').find('td.name').text()
          $('#students-checked').append("<tr class=" + thisId + "><td>" + surname + "</td><td>" + name + "</td></tr>")
          $('#selected-students, #enroll-to-class-form, #enroll-to-course-form, #enroll-to-extracurricular-activity-form').append('<input type="hidden" name="selected_students[]" value="' + thisId + '" class="' + thisId + '"/>')
          $('#students-checked-div').slideDown()
          chosen_trs = $('#chosen-table').find('tbody tr')
          $('.chosen-count').html('(' + chosen_trs.length + ')')
        else
          $('#students-checked tr.' + thisId).remove()
          $('#selected-students, #enroll-to-class-form, #enroll-to-course-form').find('input.' + thisId).remove()

          if $('#students-checked tr').length == 0
            $('#students-checked-div').slide()
          else
            chosen_trs = $('#chosen-table').find('tbody tr')
            $('.chosen-count').html('(' + chosen_trs.length + ')')

      $('body').on 'click', '.show-chosen-table', (event) ->
        event.preventDefault()
        $('.show-chosen-table').hide()
        $('.hide-chosen-table').show()
        $('#chosen-table').slide()
        $('#chosen-actions').slide()

      $('body').on 'click', '.hide-chosen-table', (event) ->
        event.preventDefault()
        $('.hide-chosen-table').hide()
        $('.show-chosen-table').show()
        $('#chosen-table').slide()
        $('#chosen-actions').slide()



  @app = new App

  (($, undefined_) ->
    $ ->
      $body = $("body")
      parent_controller = $body.data("parent-controller")
      action = $body.data("action")

      @app.init()  if $.isFunction(@app.init)
      @app[action]()  if $.isFunction(@app[action])

      activeController = @app[parent_controller]
      if activeController isnt `undefined`
        activeController.init()  if $.isFunction(activeController.init)
        activeController[action]()  if $.isFunction(activeController[action])
  ) jQuery


$(document).ready(ready)
$(window).bind('page:change', ready)
