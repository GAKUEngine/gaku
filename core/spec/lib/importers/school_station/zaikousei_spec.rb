require 'spec_helper'

describe Gaku::Core::Importers::SchoolStation::Zaikousei do

  let(:importer) { Gaku::Core::Importers::SchoolStation::Zaikousei.new() }

  before do
    create(:country, :numcode => 392, :name => "Japan")
    create(:contact_type, :name => "Phone")
    create(:state, :country_numcode => 392, :code => 23)

    @imported_file = Gaku::ImportFile.create :data_file => File.new(Rails.root + "../support/CAMPUS_ZAIKOTBL.xls"),
                            :context => 'students',
                            :importer_type => 'SchoolStation'
  end

  context 'non existing' do
    it 'imports student' do
      expect do
        importer.import(@imported_file.id)
      end.to change(Gaku::Student, :count).by 1

      student =  Gaku::Student.last
      student.addresses.count.should eq 1
      student.guardians.count.should eq 1
    end
  end

  context 'existing' do
    before do
      create(:student, :name => 'Susumu', :surname => 'Yokota', :student_foreign_id_number => 4427)
    end
    
    it "doesn't import" do
      expect do
        importer.import(@imported_file.id)
      end.to change(Gaku::Student, :count).by 0
    end
  end


end
