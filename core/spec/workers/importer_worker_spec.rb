require 'spec_helper'

describe Gaku::ImporterWorker do

  it 'works' do
    expect do
      ImporterWorker.perform_async(1)
    end.to change(ImporterWorker.jobs, :size).by 1
  end

end
