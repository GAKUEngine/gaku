# change SSE.new with rails SSE object when is released
# https://github.com/rails/rails/blob/master/actionpack/lib/action_controller/metal/live.rb
require 'json'

module Streamer
  class SSE
    def initialize(io)
      @io = io
    end

    def write(object, options = {})
      options.each do |k, v|
        @io.write "#{k}: #{v}\n"
      end
      @io.write "data: #{object}\n\n"
    end

    def close
      @io.close
    end
  end
end
