$ ->
  $("input.student-check").change ->
    thisCheck = $(this)
    thisId = $(this).closest('tr').attr('id')

    if thisCheck.is (':checked')
      surname = $(this).closest('tr').find('td.surname').text()
      name = $(this).closest('tr').find('td.name').text()
      $('#students-checked').append("<tr class=" + thisId + "><td>" + name + "</td><td>" + surname + "</td></tr>")
      $('#selected-students, #enroll-to-class-form, #enroll-to-course-form').append('<input type="hidden" name="selected_students[]" value="' + thisId + '" class="' + thisId + '"/>')
      $('#students-checked-div').slideDown()
      chosen_trs = $('#chosen-table').find('tbody tr')
      $('.chosen-count').html('(' + chosen_trs.length + ')')
    else
      $('#students-checked tr.' + thisId).remove()
      $('#selected-students, #enroll-to-class-form, #enroll-to-course-form').find('input.' + thisId).remove()

      if $('#students-checked tr').length == 0
        $('#students-checked-div').slideUp()
      else 
        chosen_trs = $('#chosen-table').find('tbody tr')
        $('.chosen-count').html('(' + chosen_trs.length + ')')

  $('.show-chosen-table').click (event) ->
    event.preventDefault()
    $('.show-chosen-table').hide()
    $('.hide-chosen-table').show()
    $('#chosen-table').show()
    $('#chosen-actions').show()

  $('.hide-chosen-table').click (event) ->
    event.preventDefault()
    $('.hide-chosen-table').hide()
    $('.show-chosen-table').show()
    $('#chosen-table').hide()
    $('#chosen-actions').hide() 