$('#modal_dialogs').html('<%== escape_javascript(render :partial => "exams/exam_modal", :formats => [:html], :handlers => [:erb, :slim], :exam => @exam) %>');
$('#edit-exam-modal').modal('show');