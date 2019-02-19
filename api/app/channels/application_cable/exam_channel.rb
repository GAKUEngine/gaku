module ApplicationCable

  class ExamChannel < ActionCable::Channel::Base
    def subscribed
      stream_from "exam_#{params['exam_id']}"
    end

    def unsubscribed
      # Any cleanup needed when channel is unsubscribed
    end
  end
end
