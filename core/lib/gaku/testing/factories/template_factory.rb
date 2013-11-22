include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :template, class: Gaku::Template do
    name 'Roster Template'
    context 'spreadsheet'
    file { fixture_file_upload(Rails.root + '../support/sample_roster.ods', 'application/vnd.oasis.opendocument.spreadsheet') }
    locked false

    factory :invalid_template do
      name nil
    end
  end

end
