$ ->
  $('.edit_note').on 'ajax:complete', (e, ajax, status) ->
    response = $.parseJSON(ajax.responseText)
    console.log response.data.title
