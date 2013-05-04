$('#new-admin-admission').html('<%= render_js_partial("gaku/admin/admissions/admissions/form") %>').slide();
$('#new-admin-admission-link').hide();
$('.remote-form').enableValidations();
