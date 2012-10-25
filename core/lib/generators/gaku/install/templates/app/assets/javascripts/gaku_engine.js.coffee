window.GAKUEngine =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->

$ -> 
  $('.delete-link').live 'ajax:success', (evt, data, status, xhr) ->
    $(this).closest('tr').remove()