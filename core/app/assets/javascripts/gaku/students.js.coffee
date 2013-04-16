# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  #student show

  $('#delete-student-link').on 'click', (e)->
    e.preventDefault()
    $('#delete-modal').modal('show')

  $(".class-group-select").combobox()

  $('#student-achievements-tab-link').on 'shown', (e)->
    $('.achievements-group').each (index, element) ->
      heights = []
      $(element).children('li').each (index, li)->
        heights.push $(li).height()
      maxHeight =  Math.max.apply(null,heights)

      $(element).find('li').children('.thumbnail').each (index, li)->
        $(@).height maxHeight




