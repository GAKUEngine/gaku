$('#modal-dialogs').html('<%= render_js_partial("modal", {:exam => @exam}) %>');
//$('#new-exam-form form').validationEngine();
$('#edit-exam-modal').modal('show');
$('.remote-form').enableValidations();
