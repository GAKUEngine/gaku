module Gaku
  class PersonDecorator < Draper::Decorator

    def sex_and_birth
      [h.gender(object), object.birth_date].join(', ')
    end

  end
end