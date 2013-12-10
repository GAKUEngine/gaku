require 'spec_helper'

feature 'Sign In' do

  let!(:admin) { create(:admin_user) }

  context 'sign in' do

    context 'as normal user' do
      let(:student) { create(:student_user) }

      background do
        visit gaku.root_path
        expect(current_path).to eq gaku.new_user_session_path
      end

      context 'valid fields' do
        it 'signs in with username' do
          fill_in 'user_login', with: student.username
          fill_in 'user_password', with: student.password
          click_button 'Sign in'
          expect(current_path).to eq gaku.root_path
        end

        it 'signs in with email' do
          fill_in 'user_login', with: student.email
          fill_in 'user_password', with: student.password
          click_button 'Sign in'
          expect(current_path).to eq gaku.root_path
        end
      end

      context 'invalid fields' do
        it 'errors if required fields are missing' do
          click_button 'Sign in'
          has_content? 'Invalid email or password.'
          expect(current_path).to eq gaku.new_user_session_path
        end

        it 'errors if login is incorrect' do
          fill_in 'user_login', with: 'fffff'
          fill_in 'user_password', with: student.password
          click_button 'Sign in'
          has_content? 'Invalid email or password.'
          expect(current_path).to eq gaku.new_user_session_path
        end

        it 'errors if password is incorrect' do
          fill_in 'user_login', with: student.username
          fill_in 'user_password', with: 'fffffff'
          click_button 'Sign in'
          has_content? 'Invalid email or password.'
          expect(current_path).to eq gaku.new_user_session_path
        end
      end
    end

    context 'as admin' do
      before do
        visit gaku.root_path
        expect(current_path).to eq gaku.new_user_session_path
      end

      xit 'signs in' do
        fill_in 'user_login', with: admin.username
        fill_in 'user_password', with: admin.password
        click_button 'Sign in'
        expect(current_path).to eq gaku.root_path

        visit gaku.admin_users_path
        has_content? 'admin@example.com'
        has_content? 'Users(1)'
      end
    end

  end

end
