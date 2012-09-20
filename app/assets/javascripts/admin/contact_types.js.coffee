$ -> 
  $(".delete_link").live "ajax:success", ->
    $(this).closest('tr').remove()
