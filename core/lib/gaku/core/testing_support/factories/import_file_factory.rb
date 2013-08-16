FactoryGirl.define do

  factory :import_file, class: Gaku::ImportFile do
    context 'students'
    #data_file File.open(Rails.root + "../support/sample_roster.xls")
  end

end
