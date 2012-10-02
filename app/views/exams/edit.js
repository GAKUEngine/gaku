$('#modal_dialogs').html('<%== render_js_partial("exams/exam_modal", {:exam => @exam}) %>');
$('#edit-exam-modal').modal('show');