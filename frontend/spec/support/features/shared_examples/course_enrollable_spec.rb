shared_examples_for 'enroll to course' do

  context 'add', js: true do

    before do
      click new_link
    end

    it { has_validations? }

    it 'creates and shows' do
      expect do
        select "#{@course.code}", from: @select
        click submit
        flash? 'successfully'
      end.to change(@data.courses, :count).by 1
      page.should have_content "#{@course.code}"

      if page.has_css?('.courses-count')
        within('.courses-count') { expect(page.has_content?('1')).to eq true }
      end

      if page.has_css?(count_div)
        within(count_div) { page.should have_content 'Courses list(1)' }
      end

      if page.has_css?(tab_link)
        within(tab_link)  { page.should have_content 'Courses(1)' }
      end

    end

    context 'validations' do

      before do
        @data.courses << @course
        @data.reload
      end

      it { has_validations? }

      it "doesn't add a course 2 times" do
        select "#{@course.code}", from: @select
        click submit
        page.has_content? 'Already enrolled'

      end
    end

  end

end

shared_examples_for 'remove enrollment' do

  it 'removes', js: true do
    course_field = @data.courses.first.code
    within(count_div) { page.should have_content 'Courses list(1)' } if page.has_css?(count_div)
    page.should have_content course_field

    expect do
      ensure_delete_is_working
      flash_destroyed?
    end.to change(@data.courses, :count).by -1

    within(count_div) { page.should_not have_content 'Courses list(1)' } if page.has_css?(count_div)
    if page.has_css?(tab_link)
      within(tab_link)  { page.should_not have_content 'Courses(1)' }
    end

    if page.has_css?('.courses-count')
      within('.courses-count') { expect(page.has_content?('0')).to eq true }
    end
    within(table) { page.should_not have_content course_field }
  end

end