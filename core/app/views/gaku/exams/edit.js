$('#modal-dialogs').html('<%= j render("modal", {:exam => @exam}) %>');
$('#edit-exam-modal').modal('show');
$('.remote-form').enableValidations();
