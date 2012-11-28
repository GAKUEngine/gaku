class GAKUEngine.Models.ExamAttendance extends Backbone.Model
  initialize: (currentTarget)->
    attendanceWidget = new GAKUEngine.Views.ExamAttendance
    popover = currentTarget.popover({ html : true, content : attendanceWidget.render() })
