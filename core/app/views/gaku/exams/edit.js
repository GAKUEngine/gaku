$('#modal-dialogs').html('<%= render_js_partial("modal", {:exam => @exam}) %>');
$('#edit-exam-modal').modal('show');
$('.remote-form').enableValidations();
