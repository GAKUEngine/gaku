# -*- encoding: utf-8 -*-

commute_method_types = [
  { name: 'Unknown',  name_ja: '不明' },
  { name: 'Walking',  name_ja: '歩行' },
  { name: 'Bicycle',  name_ja: '自転車' },
  { name: 'Train',    name_ja: '列車' },
  { name: 'Bus',      name_ja: 'バス' },
  { name: 'Car',      name_ja: '車' },
  { name: 'Metro',    name_ja: '地下鉄' }
]

commute_method_types.each do |type|
  I18n.locale = :en
  commute_method_type = Gaku::CommuteMethodType.where(name: type[:name]).first_or_create!

  I18n.locale = :ja
  commute_method_type.update_attributes(name: type[:name_ja])
end
