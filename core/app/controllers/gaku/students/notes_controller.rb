module Gaku
  class Students::NotesController < GakuController

    inherit_resources
    polymorphic_belongs_to :student
    respond_to :js, :html

  end
end
