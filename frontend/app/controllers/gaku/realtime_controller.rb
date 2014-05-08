require 'gaku/streamer/sse'

class Gaku::RealtimeController < ApplicationController
  include ActionController::Live

  # change SSE.new with rails SSE object when is released
  # https://github.com/rails/rails/blob/master/actionpack/lib/action_controller/metal/live.rb
  def exam_portion_scores
    response.headers['Content-Type'] = 'text/event-stream'
    conn = ActiveRecord::Base.connection
    sse = Streamer::SSE.new(response.stream)
    begin
      loop do
        conn.execute 'LISTEN update_exam_portion_score'
        conn.raw_connection.wait_for_notify do |_event, _pid, score|
          sse.write(score, event: 'update.examPortionScore')
        end
      end
    rescue IOError
      sse.close
      conn.execute 'UNLISTEN update_exam_portion_score'
    ensure
      sse.close
      conn.execute 'UNLISTEN update_exam_portion_score'
    end
  end

end
