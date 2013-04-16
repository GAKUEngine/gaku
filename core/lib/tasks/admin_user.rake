require 'highline/import'

namespace :gaku do
  desc "Create admin username and password"
  task :generate_admin => :environment do

  if Gaku::User.admin.empty?
    create_admin_user
  else
    puts 'Admin user has already been previously created.'
    if agree('Would you like to create a new admin user? (yes/no)')
      create_admin_user
    else
      puts 'No admin user created.'
    end
  end

  end
end

def prompt_for_admin_password
  if ENV['ADMIN_PASSWORD']
    password = ENV['ADMIN_PASSWORD'].dup
    say "Admin Password #{password}"
  else
    password = ask('Password [123456]: ') do |q|
      q.echo = false
      q.validate = /^(|.{5,40})$/
      q.responses[:not_valid] = 'Invalid password. Must be at least 5 characters long.'
      q.whitespace = :strip
    end
    password = '123456' if password.blank?
  end

  password
end


def prompt_for_admin_email
  if ENV['ADMIN_EMAIL']
    email = ENV['ADMIN_EMAIL'].dup
    say "Admin User #{email}"
  else
    email = ask('Email [admin@gaku-engine.com]: ') do |q|
      q.echo = true
      q.whitespace = :strip
    end
    email = 'admin@gaku-engine.com' if email.blank?
  end

  email
end


def prompt_for_admin_username
  if ENV['ADMIN_USERNAME']
    username = ENV['ADMIN_USERNAME'].dup
    say "Admin User #{username}"
  else
    username = ask('Username [admin]: ') do |q|
      q.echo = true
      q.whitespace = :strip
    end
    username = 'admin' if username.blank?
  end

  username
end

def create_admin_user
  if ENV['AUTO_ACCEPT']
    password = 'spree123'
    email = 'spree@example.com'
  else
    puts 'Create the admin user (press enter for defaults).'
    username = prompt_for_admin_username
    email = prompt_for_admin_email
    password = prompt_for_admin_password
  end
  attributes = {
    :password => password,
    :password_confirmation => password,
    :email => email,
    :username => username
  }


  if Gaku::User.find_by_email(email)
    say "\nWARNING: There is already a user with the email: #{email}, so no account changes were made.  If you wish to create an additional admin user, please run rake gaku:generate_admin again with a different email.\n\n"
  elsif Gaku::User.find_by_username(username)
    say "\nWARNING: There is already a user with the username: #{username}, so no account changes were made.  If you wish to create an additional admin user, please run rake gaku:generate_admin again with a different username.\n\n"
  else
    say "Creating user..."
    admin = Gaku::User.create(attributes)
    # create an admin role and and assign the admin user to that role
    role = Gaku::Role.find_or_create_by_name 'Admin'
    admin.roles << role
    if admin.save
      say "User Created"
    else
      say "User NOT Created"
    end
  end
end
