shared_examples 'avatarable' do

  it 'shows picture' do
    page.should have_css '#avatar-picture'
  end

  it "uploads", js:true do
    click "#upload-picture-link"
    absolute_path = Rails.root + "../support/120x120.jpg"
    attach_file @file_name, absolute_path
    click_button "Upload"
    flash_uploaded?
  end

end
