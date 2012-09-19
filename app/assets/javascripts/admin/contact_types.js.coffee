$ -> 
  $("#delete-contact-type-link").live "ajax:success", ->
    $(this).closest('tr').remove()
