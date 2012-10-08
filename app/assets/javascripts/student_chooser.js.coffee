  $('.js-autocomplete').each (i, element) ->
    element_id = '#' + $(element).attr('id')
    $(element_id).autocomplete
      source: $(element_id).data('autocomplete-source')
      select: (event, ui) ->
        $(this).val(ui.item.value);
        $.get($("#search-students").attr("action"), $("#search-students").serialize(), null, "script");
      
      
  $("#students-index th a").live 'click', (event) ->
    $.getScript(this.href)
    return false

  $("#search-students input").on 'keyup', (event) ->
    $.get($("#search-students").attr("action"), $("#search-students").serialize(), null, "script")
    return false

  $("#search-students select").on 'change', (event) ->
    $.get($("#search-students").attr("action"), $("#search-students").serialize(), null, "script")
    return false