class GAKUEngine.Views.ExamCompletion extends Backbone.View

  template: JST['gaku/backbone/templates/tables/exam_complеtion']

  render: ->
    $(@el).html @template(@options)
    @
