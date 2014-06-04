require 'spec_helper'

describe 'Sign Up' do

  context 'Admin' do

    before do
      visit gaku.root_path
      expect(current_path).to eq gaku.set_up_admin_account_path
      has_content? 'This is your first time running GAKU Engine. Please set up the Admin user.'
    end

    it 'signs up admin if missing' do
      expect do
        fill_in 'user_username', with: 'admin'
        fill_in 'user_email', with: 'admin@example.com'
        fill_in 'user_password', with: '12345678'
        fill_in 'user_password_confirmation', with: '12345678'
        click_button 'Sign Up'
      end.to change(Gaku::User, :count).by(1)

      expect(current_path).to eq gaku.root_path
      expect(Gaku::User.last.roles.last.to_s).to eq 'Admin'
    end

    it 'errors if fields are missing' do
      expect do
        click_button 'Sign Up'
      end.to_not change(Gaku::User, :count)

      has_content? '3 errors prohibited this user from being saved'
      has_content? "Username can't be blank"
      has_content? "Email can't be blank"
      has_content? "Password can't be blank"
    end
  end

  context 'Normal User' do

    before do
      create(:admin_user)
      visit gaku.root_path
      expect(current_path).to eq gaku.new_user_session_path

      click_link 'Sign up'
    end

    it 'signs up' do
      expect do
        fill_in 'user_username', with: 'giorgio'
        fill_in 'user_email', with: 'giorgio@example.com'
        fill_in 'user_password', with: '12345678'
        fill_in 'user_password_confirmation', with: '12345678'
        click_button 'Sign Up'
      end.to change(Gaku::User, :count).by(1)
    end

    it 'errors if fields are missing' do
      expect do
        click_button 'Sign Up'
      end.to_not change(Gaku::User, :count)

      has_content? '3 errors prohibited this user from being saved'
      has_content? "Username can't be blank"
      has_content? "Email can't be blank"
      has_content? "Password can't be blank"
    end
  end

end
