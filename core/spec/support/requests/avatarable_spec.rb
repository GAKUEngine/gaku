shared_examples 'avatarable' do

  it 'shows picture' do
    page.should have_css '#avatar-picture'
  end

  it "uploads", js:true do
    click_button "Change picture"
    absolute_path = Rails.root + "../support/120x120.jpg"
    attach_file @file_name, absolute_path
    click_button "Upload"
    flash? "successfully uploaded"
  end
  
end