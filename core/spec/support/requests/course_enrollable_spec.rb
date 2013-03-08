shared_examples_for 'enroll to course' do

  context 'add', js: true do

    before do
      click tab_link
      click new_link
      wait_until_visible submit
    end

    it { has_validations? }

    it "creates and shows" do
      expect do
        select "fall2050", from: 'course_enrollment_course_id'
        click submit
        wait_until_invisible form
      end.to change(@data.courses, :count).by 1

      page.should have_content "fall2050"
      within(count_div) { page.should have_content 'Courses list(1)' }
      within(tab_link)  { page.should have_content 'Courses(1)' }
      flash_created?
    end

    it 'cancels creating' do
      ensure_cancel_creating_is_working
    end

  end

end

shared_examples_for 'remove enrollment' do

  it "removes", js: true do
    course_field = @data.courses.first.code

    within(count_div) { page.should have_content 'Courses list(1)' }
    page.should have_content course_field

    expect do
      ensure_delete_is_working
    end.to change(@data.courses, :count).by -1

    flash_destroyed?
    within(count_div) { page.should_not have_content 'Courses list(1)' }
    if page.has_css?(tab_link)
      within(tab_link)  { page.should_not have_content 'Courses(1)' }
    end
    page.should_not have_content course_field
  end

end