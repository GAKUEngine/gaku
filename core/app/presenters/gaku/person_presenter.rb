module Gaku
  class PersonPresenter < BasePresenter
    presents :person

    def sex_and_birth
      [gender(person), person.birth_date].join(', ')
    end

  end
end
