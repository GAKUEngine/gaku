module Gaku
  class Admin::Changes::StudentChangesController < Admin::BaseController

    # load_and_authorize_resource class: StudentVersion
    respond_to :html, only: :index

    def index
      @count = Gaku::Versioning::StudentVersion.count
      @changes = Kaminari.paginate_array(Gaku::Versioning::StudentVersion.all).page(params[:page])
    end

  end
end
