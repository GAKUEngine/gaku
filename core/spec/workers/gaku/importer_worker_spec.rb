require 'spec_helper'

describe Gaku::ImporterWorker do

  let(:importer) do
    Gaku::ImportFile.create :data_file => File.new(Rails.root + "../support/CAMPUS_ZAIKOTBL.xls"),
                            :context => 'students',
                            :importer_type => 'SchoolStation'
  end

  it 'starts' do
    expect do
      Gaku::ImporterWorker.perform_async(importer.id)
    end.to change(Gaku::ImporterWorker.jobs, :size).by 1
  end

end
