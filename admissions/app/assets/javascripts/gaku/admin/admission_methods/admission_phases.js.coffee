$ ->
  fixHelper = (e, ui) ->
    ui.children().each ->
      $(@).width($(@).width())
    ui

  $('#admission-phase-portion-sorting').sortable
    handle: '.sort-handler'
    helper: fixHelper
    axis: 'y'
    update: ->
      $.post $(@).data('sort-url'), $(@).sortable('serialize')

  $('#admission-phase-portion-sorting').disableSelection()