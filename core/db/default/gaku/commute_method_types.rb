# encoding: utf-8

names = ['Unknown', 'Walking', 'Bicycle', 'Train', 'Bus', 'Car', 'Metro']

names.each do |name|
	Gaku::CommuteMethodType.create(:name => name)
end
