types = ['walking', 'bicycle','train','bus','car', 'metro']

types.each do |type|
	Gaku::CommuteMethodType.create(:name => type)
end
