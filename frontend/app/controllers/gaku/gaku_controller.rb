module Gaku
  class GakuController < CoreController

    self.responder = AppResponder
    respond_to :html

    layout :resolve_layout

    def resolve_layout
      case action_name
      when 'index'
        'gaku/layouts/index'
      when 'show'
        'gaku/layouts/show'
      when 'edit'
        'gaku/layouts/edit'
      else
        'gaku/layouts/gaku'
      end
    end

  end
end
