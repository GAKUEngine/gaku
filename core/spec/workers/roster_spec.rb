require 'spec_helper'

describe Gaku::Core::Importers::Students::RosterWorker do

it { should be_retryable true }

it 'add new job to worker' do
  file_f = create(:import_file)
  worker = Gaku::Core::Importers::Students::RosterWorker
  expect do
    worker.perform_async(file_f.id)
  end.to change(worker.jobs, :size).by(1)
end

end