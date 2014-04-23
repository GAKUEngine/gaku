require 'shared_sample_data'

school = Gaku::School.where(  name: 'Test School',
                              slogan: 'Test School Slogan',
                              founded: Time.now,
                              principal: 'Test School Principal',
                              vice_principal: 'Test School Vice Principal'
                            ).first_or_create!

campus1 = school.campuses.where(name: 'Biology Campus').first_or_create!
campus2 = school.campuses.where(name: 'Informatics Campus').first_or_create!

campus1.address = Gaku::Address.where(random_address.merge(addressable: campus1)).first_or_create!
campus1.contacts.where(random_email).first_or_create!
campus1.contacts.where(random_home_phone).first_or_create!
campus1.contacts.where(random_mobile_phone).first_or_create!

campus2.address = Gaku::Address.where(random_address.merge(addressable: campus2)).first_or_create!
campus2.contacts.where(random_email).first_or_create!
campus2.contacts.where(random_home_phone).first_or_create!
campus2.contacts.where(random_mobile_phone).first_or_create!