module Gaku
  class Admin::HomeController < Admin::BaseController

    def index
      @contact_types = ContactType.all
      @count = ContactType.count
      respond_with @contact_types
    end

  end
end
