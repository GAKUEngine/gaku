require 'spec_helper'

describe Gaku::StudentWorker do

  it 'imports' do
    expect do
      Gaku::StudentWorker.perform_async('import', 1)
    end.to change(Gaku::StudentWorker.jobs, :size).by 1
  end

end
