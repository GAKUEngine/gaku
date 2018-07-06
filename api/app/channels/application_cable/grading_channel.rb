module ApplicationCable

  class GradingChannel < ActionCable::Channel::Base
    def subscribed
      stream_from "grading_exam_#{params['exam_id']}"
    end

    def unsubscribed
      # Any cleanup needed when channel is unsubscribed
    end
  end
end
