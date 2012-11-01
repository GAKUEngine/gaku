# encoding: utf-8

names = ['Walking', 'Bicycle','Train','Bus','Car', 'Metro']

names.each do |name|
	Gaku::CommuteMethodType.create(:name => name)
end
