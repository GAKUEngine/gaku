$('#modal_dialogs').html('<%== render_js_partial("exams/exam_modal", {:exam => @exam}) %>');
$('#new-exam-form form').validationEngine();
$('#edit-exam-modal').modal('show');