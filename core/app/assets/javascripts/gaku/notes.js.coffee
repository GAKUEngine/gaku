ready = ->

  $("#submit-" + notable_resource + "-note-button").live "ajax:success", (data, status, xhr)->
    $("#new-" + notable_resource + "-note-link").show()
    $("#new-" + notable_resource + "-note form").slide()

$(document).ready(ready)
$(document).on('page:load', ready)