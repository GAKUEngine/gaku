module Gaku::Importers::KeyMapper
  def get_keymap(key_syms)
    keymap = {}
    key_syms.each do |key|
      keymap[key] = '^' + I18n.t(key) + '$'#.gsub(' ', ' ')
    end
    keymap
  end

  def filter_keymap(keymap,book)
    filtered_keymap = {}
    keymap.each do |key, value|
      book.each do |row|
        filtered_keymap[key] = value if row.grep(/#{value}/i).any?
      end
    end
    filtered_keymap
  end
end
