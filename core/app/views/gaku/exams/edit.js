$('#modal-dialogs').html('<%== render_js_partial("gaku/exams/exam_modal", {:exam => @exam}) %>');
$('#new-exam-form form').validationEngine();
$('#edit-exam-modal').modal('show');