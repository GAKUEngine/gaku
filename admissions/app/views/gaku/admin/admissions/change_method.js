alert('#{@admission_method}')
$('#admission-phases').html('<%= render_js_partial("phases", {:admission_method => @admission_method}) %>');
$('#new-admin-admission-links').html('<%= render_js_partial("links", {:admission_method => @admission_method}) %>');