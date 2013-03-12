# -*- encoding: utf-8 -*-

#names = %w(Unknown Walking Bicycle Train Bus Car Metro)

#names.each do |name|
#	Gaku::CommuteMethodType.where(:name => name).first_or_create!
#end

# -*- encoding: utf-8 -*-
# Array format ['en commute_method_type', 'ja commute_method_type', 'is_active?']
commute_method_types = [
  ['Unknown',  '不明'],
  ['Walking',  '歩行'],
  ['Bicycle',  '自転車'],
  ['Train',    '列車'],
  ['Bus',      'バス'],
  ['Car',      '車'],
  ['Metro',    '地下鉄']
]

commute_method_types.each do |type|
  I18n.locale = :en
  commute_method_type = Gaku::CommuteMethodType.where(:name => type[0]).first_or_create!

  I18n.locale = :ja
  commute_method_type.update_attribute(:name,  type[1])
end

I18n.locale = nil