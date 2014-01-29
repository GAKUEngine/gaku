module Gaku
  class SearchController < GakuController

    respond_to :json, only: :search

    def students
      if params[:class_name]
        object = "Gaku::#{params[:class_name].classify}".constantize
        @result = object.order(params[:column].to_sym)
                        .where(params[:column] + ' like ?', "%#{params[:term]}%")
        render json: @result.map(&params[:column].to_sym).uniq
      end
    end

  end
end
