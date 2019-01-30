require 'carmen'

Carmen::Country.all.each do |country|
  next if Gaku::Country.exists?(iso: country.alpha_2_code)

  Gaku::Country.create!(name: country.name,
                        iso3: country.alpha_3_code,
                        iso: country.alpha_2_code,
                        iso_name: country.name.upcase,
                        numcode: country.numeric_code,
                        states_required: country.subregions?)
end
