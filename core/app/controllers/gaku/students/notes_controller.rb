module Gaku
  class Students::NotesController < GakuController

    skip_authorization_check

    inherit_resources
    polymorphic_belongs_to :student
    respond_to :js, :html

  end
end
