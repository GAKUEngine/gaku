Gaku::School.where( :name => 'Our School',
                    :is_primary => true,
                    :slogan => 'Our Slogan',
                    :founded => Time.now,
                    :principal => 'Our Principal',
                    :vice_principal => 'Our Vice Principal').first_or_create!
