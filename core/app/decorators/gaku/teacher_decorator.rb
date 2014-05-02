module Gaku
  class TeacherDecorator < PersonDecorator
    decorates 'Gaku::Teacher'
    delegate_all
  end
end
