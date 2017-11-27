require 'spec_helper'

describe 'Selecting Students', type: :feature do

  before(:all) { set_resource 'student' }

  let(:admin) { create(:admin_user) }

  let!(:preset) { create(:preset, chooser_fields: { show_name: '1', show_surname: '1' }) }

  let(:enrollment_status_admitted) { create(:enrollment_status_admitted) }

  let(:student) do
    create(:student, name: 'John', surname: 'Doe', enrollment_status_code: enrollment_status_admitted.code)
  end

  let(:student2) do
    create(:student, name: 'Susumu', surname: 'Yokota', enrollment_status_code: enrollment_status_admitted.code)
  end

  before do
    as admin
    Gaku::StudentSelection.new(admin).remove_all
  end

  context 'existing' do
    before do
      enrollment_status_admitted
      student
      student2
      visit gaku.students_path
    end

    it 'saves the selection', js: true do
      find(:css, "input#student-#{student.id}").set(true)
      find(:css, "input#student-#{student2.id}").set(true)
      page.has_selector? '#students-checked-div'
      page.has_content? 'Collector2'

      visit gaku.root_path
      visit gaku.students_path

      find(:css, "input#student-#{student.id}").should be_checked
      find(:css, "input#student-#{student2.id}").should be_checked
      page.has_selector? '#students-checked-div'
      page.has_content? 'Collector2'
    end

    it 'unchecks preselected students', js: true do
      find(:css, "input#student-#{student.id}").set(true)
      find(:css, "input#student-#{student2.id}").set(true)
      page.has_selector? '#students-checked-div'
      page.has_content? 'Collector2'

      visit gaku.root_path
      visit gaku.students_path

      find(:css, "input#student-#{student.id}").should be_checked
      find(:css, "input#student-#{student2.id}").should be_checked
      find(:css, "input#student-#{student.id}").set(false)

      find(:css, "input#student-#{student.id}").should_not be_checked
      page.has_selector? '#students-checked-div'
      expect(page.has_content?('Collector1')).to eq true
    end

    it 'clears preselected students', js: true do
      find(:css, "input#student-#{student.id}").set(true)
      find(:css, "input#student-#{student2.id}").set(true)
      page.has_selector? '#students-checked-div'
      page.has_content? 'Collector2'

      visit gaku.root_path
      visit gaku.students_path

      find(:css, "input#student-#{student.id}").should be_checked
      find(:css, "input#student-#{student2.id}").should be_checked

      find(:css, '#btn-students-chooser').click
      sleep 1
      
      find(:css, '#clear-student-selection').click
      sleep 1

      find(:css, "input#student-#{student.id}").should_not be_checked
      find(:css, "input#student-#{student2.id}").should_not be_checked
      !page.has_selector? '#students-checked-div'
      expect(page.has_content?('Collector1')).to eq false
    end

    it 'removes selected student', js: true do
      find(:css, "input#student-#{student.id}").set(true)
      find(:css, '#btn-students-chooser').click
      sleep 1
      page.has_selector? '#students-checked-div'
      page.has_content? 'Collector1'
      find(:css, '.remove-student').click
      sleep 1
      find(:css, "input#student-#{student.id}").should_not be_checked
      page.has_content? 'Collector1'

      visit gaku.root_path
      visit gaku.students_path

      find(:css, "input#student-#{student.id}").should_not be_checked

      !page.has_selector? '#students-checked-div'
      expect(page.has_content?('Collector1')).to eq false
    end

    it 'click icon and add all selected students', js: true do
      click '.check-all'

      page.has_selector? '#students-checked-div'
      page.has_content? 'Collector2'

      visit gaku.root_path
      visit gaku.students_path

      find(:css, "input#student-#{student.id}").should be_checked
      find(:css, "input#student-#{student2.id}").should be_checked
      page.has_selector? '#students-checked-div'
      page.has_content? 'Collector2'
    end

    it 'click icon twice and remove all selected students', js: true do
      click '.check-all'

      find(:css, "input#student-#{student.id}").should be_checked
      find(:css, "input#student-#{student2.id}").should be_checked

      page.has_selector? '#students-checked-div'
      page.has_content? 'Collector2'

      click '.check-all'

      find(:css, "input#student-#{student.id}").should_not be_checked
      find(:css, "input#student-#{student2.id}").should_not be_checked

      page.has_selector? '#students-checked-div'
      page.has_content? 'Collector0'

      visit gaku.root_path
      visit gaku.students_path

      find(:css, "input#student-#{student.id}").should_not be_checked
      find(:css, "input#student-#{student2.id}").should_not be_checked
      !page.has_selector? '#students-checked-div'
      !page.has_content? 'Collector2'
    end

  end

end
