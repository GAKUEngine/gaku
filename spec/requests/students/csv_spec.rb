require 'spec_helper'

describe 'CSV' do
  stub_authorization!

  context 'download' do 
    it 'should export students as CSV' do
      Factory(:student, :name => 'John', :surname => 'Doe')
      Factory(:student, :name => 'Susumu', :surname => 'Yokota')
      visit students_path

      click_link 'export-students-link'
      page.response_headers['Content-Type'].should eq "text/csv"
      page.should have_content('surname,name')
      page.should have_content('Doe,John')
      page.should have_content('Yokota,Susumu')
    end

    it 'should download student registration csv' do 
      visit students_path
      click_link 'import-students-link'
      click_link 'get_registration_csv'

      page.response_headers['Content-Type'].should eq "text/csv"
      page.should have_content('surname,name,surname_reading,name_reading,gender,phone,email,birth_date,admitted')
    end
  end

  context 'upload' do 
    it 'should import students from CSV' do
      Student.all.count.should eql(0)
      visit students_path
      click_link 'import-students-link'
      select "GAKU Engine", :from => 'importer_importer_type'
      absolute_path = Rails.root + "spec/support/students.csv"
      attach_file('importer_data_file', absolute_path)
      click_button 'Submit'

      page.should have_content('created students:2')
      Student.all.count.should eql(2)
    end
  end
  
end