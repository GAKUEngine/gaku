# -*- encoding: utf-8 -*-
module Gaku

  class StudentWorker
    include Sidekiq::Worker

    def perform(id)
    end


  end
end
