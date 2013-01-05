# encoding: utf-8

names = %w(Unknown, Walking, Bicycle, Train, Bus, Car, Metro)

names.each do |name|
	Gaku::CommuteMethodType.where(:name => name).first_or_create
end
