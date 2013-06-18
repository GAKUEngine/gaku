$ ->
  $(document).on 'keydown', '.js-autocomplete', (event) ->
    element_id = '#' + $(this).attr('id')
    $(element_id).autocomplete
      source: $(element_id).data('autocomplete-source')
      messages:
        noResults: ->
        results: ->
      select: (event, ui) ->
        $(this).val(ui.item.value);
        $.get($("#search-students").attr("action"), $("#search-students").serialize(), null, "script");


  $(document).on 'click', "#students-index th a", (event) ->
    $.getScript(this.href)
    return false

  $(document).on 'keyup', "#search-students input", (event) ->
    $.get($("#search-students").attr("action"), $("#search-students").serialize(), null, "script")
    return false

  $(document).on 'change', "#search-students select", (event) ->
    $.get($("#search-students").attr("action"), $("#search-students").serialize(), null, "script")
    return false