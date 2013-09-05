ready = ->

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


  #should be included where addresses is needed
  $('body').on 'change', '#country_dropdown', ->
    countryCode = $("#country_dropdown option:selected").val()
    if countryCode
      $.ajax
        type: 'get'
        url: '/states'
        dataType: 'script'
        data:
          country_id: countryCode



$(document).ready(ready)
$(document).on('page:load', ready)
