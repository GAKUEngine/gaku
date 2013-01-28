module Gaku
  module Admin
    class ExamPortionScoresController < GakuController

      inherit_resources
      respond_to :js, :html, :json

    end
  end
end