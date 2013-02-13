# encoding: utf-8

roles = %w(Admin program_manager Instructor Counselor Staff Principal vice_principal Student Guardian)

roles.each do |role|
  Gaku::Role.where(:name => role).first_or_create!
end
