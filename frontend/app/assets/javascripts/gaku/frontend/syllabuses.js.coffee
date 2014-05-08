ready = ->

  class SyllabusesController
    edit: ->

  @app.syllabuses = new SyllabusesController

$(document).ready(ready)
$(document).on('page:load', ready)