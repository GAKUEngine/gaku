Gaku::Country.where(states_required: true).each do |country|
  carmen_country = Carmen::Country.named(country.name)

  carmen_country.subregions.each do |subregion|
    unless Gaku::State.exists?(name: subregion.name, country_iso: country.iso)
      Gaku::State.create!(name: subregion.name, abbr: subregion.code, country_iso: country.iso)
    end
  end
end
