require 'spec_helper'

describe User do

  context "validations" do 
  	it { should have_valid_factory(:user) }
  end
  
end# == Schema Information
#
# Table name: users
#
#  id                     :integer         not null, primary key
#  sign_in_count          :integer         default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  email                  :string(255)
#  encrypted_password     :string(255)
#  created_at             :datetime        not null
#  updated_at             :datetime        not null
#  admin                  :boolean         default(FALSE)
#  locale                 :string(255)
#

