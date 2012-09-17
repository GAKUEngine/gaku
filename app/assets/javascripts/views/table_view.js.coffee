class GAKUEngine.Views.TableView extends Backbone.View


  template: JST['table/table']

  events:
    'blur .portion_score_update': 'validatePortion'
    'click .portion_score_update input': 'removeBorder'

  render: ->
    $(this.el).html @template(course: @options.course, exams: @options.exams, student_total_scores: @options.student_total_scores, exam_averages: @options.exam_averages, deviation: @options.deviation, students: @options.students)
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

  TableFix: ()->
    $("html").css "overflow-x", "hidden"
    $("html").css "overflow-y", "hidden"

    fixW = 303
    fixW += $(".btn-warning").length * 131
    if $(".exam_infos").length > 1
      fixW += ($(".btn-inverse").length - 1) * 76
      fixW += 302
    else
      fixW += $(".btn-inverse").length * 76
    $(".exam_grid").width(fixW)

    if fixW > $(window).width() - 80
      fixW = $(window).width() - 80
    fixH = $(".exam_grid").height()
    if fixH > $(window).height() - $(".exam_grid").offset().top - 40
      fixH = $(window).height() - $(".exam_grid").offset().top - 40
    # $('.exam_grid').tablefix({width: fixW, height: fixH, fixRows: 2, fixCols: 3})

  updataPortion:(urlLink, score, baseURI) ->
    @exam_score = new GAKUEngine.Models.ExamPortionScore
      urlLink: urlLink
      score: score
      baseURI: baseURI

  removeBorder:(event)->
    $(event.currentTarget).removeClass('score-error')
