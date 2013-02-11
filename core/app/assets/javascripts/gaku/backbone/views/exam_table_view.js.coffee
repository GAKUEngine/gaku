class GAKUEngine.Views.ExamTableView extends Backbone.View

  template: JST['gaku/backbone/templates/tables/exam_table']

  events:
    'blur       .portion_score_update':         'validatePortion'
    'keypress   .portion_score_update' :        'onEnterActions'
    'click      .portion_set_attendance' :      'setPortionAttendance'
    'click      .portion_score_update input':   'removeBorder'


  render: ->
    optionsObjects =  {
                        course: @options.course,
                        exams: @options.exams,
                        student_total_scores: @options.student_total_scores,
                        exam_averages: @options.exam_averages,
                        deviation: @options.deviation,
                        students: @options.students,
                        grades: @options.grades,
                        ranks: @options.ranks
                        attendances: @options.attendances
                        path_to_exam: @options.path_to_exam
                      }
    @$el.html @template(optionsObjects)
    _.defer ->
      userView = new GAKUEngine.Views.ExamUserView(optionsObjects)
      $('#exam-grading-user').html userView.render().el

      scoreView = new GAKUEngine.Views.ExamScoreView(optionsObjects)
      $('#exam-grading-score').html scoreView.render().el

      calculationsView = new GAKUEngine.Views.ExamCalculationsView(optionsObjects)
      $('#exam-grading-calculations').html calculationsView.render().el
    @


  onEnterActions: (event)->
    if !event.shiftKey && event.keyCode == 13
      @nextOnEnter(event)
    else if event.shiftKey && event.keyCode == 13
      @prevOnShiftEnter(event)


  prevOnShiftEnter: (event)->
    event.preventDefault()
    $this = $(event.target)

    portion = $this.parent().attr('class')
    prevDiv = $this.closest('tr').prev().find('.'+portion)
    input = prevDiv.find('.score-cell')

    if input[0]?
      input.focus()
    else
      prevPortionTD = $this.closest('td').prev()
      if prevPortionTD.attr('class') == 'score-column'
        prevPortionClass = $(prevPortionTD).find('div:nth-child(1)').attr('class')
        $this.closest('tbody')
              .find('tr')
              .eq('-2')
              .find('div.'+prevPortionClass)
              .find('input.score-cell')
              .focus()

      else
        $this.closest('tbody')
                .find('tr')
                .eq('-2')
                .find('input.score-cell')
                .last()
                .focus()

    return false


  nextOnEnter: (event)->
      event.preventDefault()
      $this = $(event.target)

      portion = $this.parent().attr('class')
      nextDiv = $this.closest('tr').next().find('.'+portion)
      input = nextDiv.find('.score-cell')

      if input[0]?
        input.focus()
      else
        nextPortionTD = $this.closest('td').next()
        if nextPortionTD.attr('class') == 'score-column'
          nextPortionClass = $(nextPortionTD).find('div:nth-child(1)').attr('class')
          $this.closest('tbody')
                .find('tr:first-child')
                .find('div.' + nextPortionClass)
                .find('input.score-cell')
                .focus()

        else
          $this.closest('tbody')
                .find('tr:first-child')
                .find('input.score-cell')
                .first()
                .focus()
      return false


  setPortionAttendance: (event)->
    currentTarget = $(event.currentTarget)
    attendanceId  = $(currentTarget).attr('data-attendance')
    attendanceUrl = $(currentTarget[0]).attr('action') + '/attendances'
    examPortionScore = $(currentTarget).closest('td').attr('id')

    if attendanceId
      attendance = new GAKUEngine.Models.Attendance()
      attendance.url = "#{attendanceUrl}/#{attendanceId}"
      attendance.fetch
        success: =>
          attendance_types = new GAKUEngine.Collections.AttendanceTypes()
          attendance_types.on 'reset', =>
            attendanceView = new GAKUEngine.Views.ExamAttendance(
                                      attendance_types : attendance_types,
                                      attendanceUrl : attendanceUrl,
                                      currentTarget : currentTarget,
                                      examPortionScore: examPortionScore,
                                      attendance: attendance)

            @renderAttendancePopover(currentTarget, attendanceView)
          # currentTarget.popover
          #   trigger: 'manual'
          #   html : true
          #   content: ->
          #     attendanceView.render().el
          # currentTarget.popover 'toggle'

          attendance_types.fetch()

    else
      attendance_types = new GAKUEngine.Collections.AttendanceTypes()
      attendance_types.on 'reset', =>
        attendanceView = new GAKUEngine.Views.ExamAttendance(
                                  attendance_types : attendance_types,
                                  attendanceUrl : attendanceUrl,
                                  currentTarget : currentTarget,
                                  examPortionScore: examPortionScore)

        @renderAttendancePopover(currentTarget, attendanceView)

      attendance_types.fetch()

  renderAttendancePopover: (target, view)->
    target.popover
      trigger: 'toggle'
      html : true
      content: ->
        view.render().el
    if target.data('popover').$tip
      if target.data('popover').$tip.is(':visible')
        target.popover 'hide'
      else
        target.popover 'show'
    else
      target.popover 'show'

  validatePortion: (event)->
    currentTarget      = $(event.currentTarget)
    currentTargetInput = currentTarget.find('input')
    currentTargetValue = currentTargetInput.attr('value')
    maxScore           = currentTarget.closest('form').data('max-score')

    if currentTargetValue > maxScore or currentTargetValue < 0
      currentTargetInput.addClass('score-error')
    else
      @updatePortion(currentTarget.attr('action'), event.target.value, event.target.baseURI )


  updatePortion:(urlLink, score, baseURI) ->
    @exam_score = new GAKUEngine.Models.ExamPortionScore
      urlLink: urlLink
      score: score
      baseURI: baseURI



  removeBorder:(event)->
    $(event.currentTarget).removeClass('score-error')
