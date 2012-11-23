class GAKUEngine.Views.ExamTableView extends Backbone.View

  template: JST['gaku/backbone/templates/tables/exam_table']

  events:
    'blur .portion_score_update': 'validatePortion'
    'click .portion_score_update input': 'removeBorder'
    'click .portion_set_attendance' : 'setPortionAttendance'
    'keypress .portion_score_update' : 'nextOnEnter'


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
                      }
    
    $(this.el).html @template(optionsObjects)
    _.defer ->
      userView = new GAKUEngine.Views.ExamUserView(optionsObjects)
      $('#exam-grading-user').html userView.render().el
      
      scoreView = new GAKUEngine.Views.ExamScoreView(optionsObjects)
      $('#exam-grading-score').html scoreView.render().el

      calculationsView = new GAKUEngine.Views.ExamCalculationsView(optionsObjects)
      $('#exam-grading-calculations').html calculationsView.render().el
    @


  nextOnEnter: (event)->
    if event.keyCode == 13

      event.preventDefault()
      $this = $(event.target) 

      portion = $this.parent().attr('class')
      nextDiv = $this.closest('tr').next().find('.'+portion)
      input = nextDiv.find('.score-cell')

      if input[0] != undefined
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
    inputElement = $('#' + currentTarget.attr("targetinputelement"))
    inputElement.hide()

  validatePortion: (event)->
    currentTarget = $(event.currentTarget)
    currentTargetInput = currentTarget.find('input')
    currentTargetValue = currentTargetInput.attr('value')
    maxScore = $(event.currentTarget).data('max-score')

    if currentTargetValue > maxScore
      currentTargetInput.addClass('score-error')
    else if currentTargetValue < 0
      currentTargetInput.addClass('score-error')
    else
      @updataPortion(currentTarget.attr('action'), event.target.value, event.target.baseURI )

  updataPortion:(urlLink, score, baseURI) ->
    @exam_score = new GAKUEngine.Models.ExamPortionScore
      urlLink: urlLink
      score: score
      baseURI: baseURI

  removeBorder:(event)->
    $(event.currentTarget).removeClass('score-error')
