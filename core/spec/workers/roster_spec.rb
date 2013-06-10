require 'spec_helper'

describe Gaku::Core::Importers::Students::RosterWorker do

it { should be_retryable true }

it 'opa' do
  expect( subject.perform('opa') ).to have_enqueued_jobs(1)
end

end