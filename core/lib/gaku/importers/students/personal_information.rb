module Gaku::Importers::Students::PersonalInformation
  def add_contacts(row, person)
    phone = row[:phone]
    unless person.contacts.where(contact_type_id: Gaku::ContactType.where(
      name: 'Phone').first.id,   data: phone).exists?
      person.contacts.create!(contact_type_id:
        Gaku::ContactType.wherprimary: true,
                              emergency: true, data: phone) unless (phone.nil? || phone == '')
    end

    email = row[:email]
    unless person.contacts.where(contact_type_id: Gaku::ContactType.where(
      name: 'Email').first.id,   data: email).exists?
      person.contacts.create!(contact_type_id: Gaku::ContactType.where(name: 'Email').first.id, primary: true,
                              emergency: true, data: email) unless (email.nil? || email == '')
    end
  end

  def add_address(row, person)
    if row[:'address.address1']
      state = nil
      unless (row[:'address.state'].nil? || row[:'address.state'] == '')
        state = Gaku::State.where(name: row[:'address.state']).first
        if state == nil
          log 'State: "' + row[:'address.state'] + '" not found. Please register and retry import.'
          return
        end
      end

      country = Gaku::Country.where(name: '日本').first
      unless Gaku::Country.where(name: row[:'address.country']).first.nil?
        country = Gaku::Country.where(name: row[:'address.country']).first
      end

      unless person.addresses.where(zipcode: row[:'address.zipcode'].to_s,
                                    country_id: country.id, state_id: state.id, city: row[:'city'],
                                    address1: row[:'address.address1'], address2: row[:'address.address2']).exists?

        person_address = person.addresses.create!(zipcode: row[:'address.zipcode'],
                                                  country_id: country.id, state: state, city: row[:'city'],
                                                  address1: row[:'address.address1'], address2: row[:'address.address2'])
      end
    end
  end

  def reg_sex(row, person)
    gender = nil
    if row[:sex] == I18n.t('gender.female')
      gender = 0
    elsif row[:sex] == I18n.t('gender.male')
      gender = 1
    end
    person.gender = gender
  end

  def reg_birthdate(row, person)
    #birth_date = Date.strptime(row['birth_date']).to_s
    #begin
    #  birth_date = Date.strptime(row['birth_date'].to_s, "%Y/%m/%d")
    #rescue
    #  birth_date = Date.civil(1899, 12, 31) + row['birth_date'].to_i.days - 1.day
    #end
    person.birth_date = row[:birth_date]
  end
end
