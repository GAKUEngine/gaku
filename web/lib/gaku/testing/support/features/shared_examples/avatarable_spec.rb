shared_examples 'upload avatar' do

  it 'uploads', js:true do
    sleep 0.5
    click '#upload-picture-link'
    attach_file @file_name, picture_path
    click_button 'Upload'
    flash_updated?
  end

end


shared_examples 'show avatar' do

  it 'shows avatar' do
    page.should have_css '#avatar-picture'
  end

end