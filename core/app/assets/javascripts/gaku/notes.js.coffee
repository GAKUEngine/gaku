$ ->
  $("#submit-" + notable_resource + "-note-button").live "ajax:success", (data, status, xhr)->
    #add new record to list
    $("#new-" + notable_resource + "-note-link").show()
    $("#new-" + notable_resource + "-note form").slide()
