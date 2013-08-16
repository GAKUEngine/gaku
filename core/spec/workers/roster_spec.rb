require 'spec_helper'

describe Gaku::Importers::Students::Roster do

  it 'add new job to worker' do
    file_f = create(:import_file)
    worker = Gaku::Importers::Students::RosterWorker
    worker.perform_async(file_f.id)
    expect(worker).to have(1).enqueued.jobs
  end

end

