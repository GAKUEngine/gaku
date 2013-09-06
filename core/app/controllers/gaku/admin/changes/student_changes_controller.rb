module Gaku
  class Admin::Changes::StudentChangesController < Admin::BaseController

    #load_and_authorize_resource class: StudentVersion
    respond_to :html

    def index
      @count = Gaku::Versioning::StudentVersion.count
      @changes = Gaku::Versioning::StudentVersion.all
    end

  end
end
