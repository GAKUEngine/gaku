FactoryGirl.define do
  factory :state, class: Gaku::State do
    name 'Alabama'
    abbr 'AL'
    country do |country|
      usa = Gaku::Country.find_by_numcode(840)
      if usa
        country = usa
      else
        country.association(:country)
      end
    end
  end
end
