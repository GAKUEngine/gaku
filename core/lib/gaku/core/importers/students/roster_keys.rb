module Gaku::Core::Importers::Students::RosterKeys
  KEY_SYMS = [:student_id_number, :student_foreign_id_number, :name,
    :name_reading, :middle_name, :middle_name_reading, :surname,
    :surname_reading, :sex, :birth_date, :admitted, :phone, :email,
    :'address.zipcode', :'address.country', :'address.state',
    :'address.city', :'address.address2', :'address.address1']
    
  def get_keymap(key_syms = KEY_SYMS)
    keymap = {}
    key_syms.each do |key|
      keymap[key] = '^' + I18n.t(key) + '$'#.gsub(' ', ' ')
      log 'KEY[' + key.to_s + ']: ' + keymap[key]
    end
    return keymap
  end

  def filter_keymap(keymap,book)
    filtered_keymap = {}
    keymap.each do |key, value|
      book.each do |row|
        filtered_keymap[key] = value if row.grep(/#{value}/i).any?
      end
    end
    return filtered_keymap
  end
end
