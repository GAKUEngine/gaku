require 'spec_helper'

describe 'Student CSV' do

  stub_authorization!

  context 'download' do 
    it 'exports as CSV' do
      create(:student, :name => 'John', :surname => 'Doe')
      create(:student, :name => 'Susumu', :surname => 'Yokota')
      visit students_path

      click_link 'export-students-link'
      page.response_headers['Content-Type'].should eq "text/csv"
      page.should have_content 'surname,name'
      page.should have_content 'Doe,John'
      page.should have_content 'Yokota,Susumu'
    end

    it 'downloads registration CSV' do 
      visit students_path
      click_link 'import-students-link'
      click_link 'get_registration_csv'

      page.response_headers['Content-Type'].should eq "text/csv"
      page.should have_content 'surname,name,surname_reading,name_reading,gender,phone,email,birth_date,admitted'
    end
  end

  context 'upload' do 
    it 'imports from CSV' do
      visit students_path

      expect do 
        click_link 'import-students-link'
        select "GAKU Engine", :from => 'importer_importer_type'
        absolute_path = Rails.root + "spec/support/students.csv"
        attach_file 'importer_data_file', absolute_path
        click_button 'Submit'
      end.to change(Student, :count).by 2

      page.should have_content 'created students:2'
    end
  end
  
end