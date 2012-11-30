window.GAKUEngine =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->

$ -> 
  $('.delete-link').live 'ajax:success', (evt, data, status, xhr) ->
    $(this).closest('tr').remove()

  # small plugin for fadeOut notices after 2sec when notice is showed	
  window.showNotice = (notice)->
    $('#notice').html(notice).delay(3000).fadeOut ->
      $(@).html('').show()
 
  $(".cancel-link").live "click", (e) ->
    event.preventDefault()
    resource_id = $(this).attr("id").replace("cancel-", "").replace("-link", "")
    resource_new_link = "#new-" + resource_id + "-link"
    resource_form = "#new-" + resource_id
    $(resource_new_link).show()
    $(resource_form).slideUp()
