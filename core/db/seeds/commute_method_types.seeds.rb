types = ['walking', 'bicycle','train','bus','car', 'metro']

types.each do |type|
	CommuteMethodType.create(:name => type)
end
