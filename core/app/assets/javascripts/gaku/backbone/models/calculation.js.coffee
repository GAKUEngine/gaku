class GAKUEngine.Models.Calculation extends Backbone.Model

  initialize: ->
    @on 'change', @reRenderCalculationsView, @

  reRenderCalculationsView: ->
    calculationsView = new GAKUEngine.Views.ExamCalculationsView
                              course: @get('course')
                              exams: @get('exams')
                              student_total_scores: @get('student_total_scores')
                              exam_averages: @get('exam_averages')
                              deviation: @get('deviation')
                              students: $.parseJSON(@get('students'))
                              grades: @get('grades')
                              ranks: @get('ranks')

    $('#exam-grading-calculations').html calculationsView.render().el

    completionView = new GAKUEngine.Views.ExamCompletion(exam: @get('exams')[0], completion: @get('completion')  )
    $('.exam-name-info').html completionView.render().el


    # console.log("calcualation.js dayo-")
    # tableSizeFix = ->
    #   $("html").css "overflow-x", "hidden"
    #   $("html").css "overflow-y", "hidden"
    #   fixW = 303
    #   fixW += $(".btn-warning").length * 131
    #   if $(".exam_infos").length > 1
    #     fixW += ($(".btn-inverse").length - 1) * 76
    #     fixW += 302
    #   else
    #     fixW += $(".btn-inverse").length * 76
    #   $(".exam_grid").width(fixW)
    #   if fixW > $(window).width() - 80
    #     fixW = $(window).width() - 80
    #   fixH = $(".exam_grid").height()
    #   if fixH > $(window).height() - $(".exam_grid").offset().top - 40
    #     fixH = $(window).height() - $(".exam_grid").offset().top - 40
    #   $('.exam_grid').tablefix({width: fixW, height: fixH, fixRows: 2, fixCols: 3})
    # tableSizeFix()
