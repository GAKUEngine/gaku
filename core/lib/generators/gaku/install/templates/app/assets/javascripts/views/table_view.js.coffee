class GAKUEngine.Views.TableView extends Backbone.View


  template: JST['table/table']

  events:
    'blur .portion_score_update': 'validatePortion'
    'click .portion_score_update input': 'removeBorder'

  render: ->
    $(this.el).html @template(course: @options.course, exams: @options.exams, student_total_scores: @options.student_total_scores, exam_averages: @options.exam_averages, deviation: @options.deviation, students: @options.students, grades: @options.grades, ranks: @options.ranks)
    @

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
