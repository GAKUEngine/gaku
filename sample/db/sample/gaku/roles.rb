# encoding: utf-8

roles = %w(Admin ProgramManager Instructor Counselor Staff Principal VicePrincipal Student Guardian)

say "Creating #{roles.size} roles ...".yellow

roles.each do |role|
  Gaku::Role.where(name: role).first_or_create!
end
