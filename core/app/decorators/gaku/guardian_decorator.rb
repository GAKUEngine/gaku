module Gaku
  class GuardianDecorator < PersonDecorator
    decorates 'Gaku::Guardian'
    delegate_all
  end
end

