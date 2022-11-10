require 'rails_helper'

RSpec.describe 'ユーザ管理機能テスト', type: :system do
  describe '登録機能' do
    context 'ユーザの新規登録' do
      it 'タスク一覧画面に遷移する' do
        visit new_user_path
        fill_in 'Name', with: 'user1'
        fill_in 'Email', with: 'user1@gmail.com'
        fill_in 'Password', with: '1111111'
        fill_in 'Password confirmation', with:'1111111'
        click_on 'Create my account'
        expect(page).to have_content 'タスク一覧' 
      end
    end

    context 'ログインせずにタスク一覧画面に飛ぼうとした時' do
      it 'ログイン画面に遷移する' do
        visit tasks_path
        expect(page).to have_content 'Login'
      end
    end
  end

  describe 'セッション機能テスト' do
    let!(:first_user){FactoryBot.create(:first_user)}
    let!(:second_user){FactoryBot.create(:second_user)}
    before do
      visit new_session_path
      fill_in 'session_email', with: 'user1@gmail.com'
      fill_in 'session_password', with: '1111111'
      click_button 'ログイン'
    end
  
    context '登録済みのユーザでログインした場合' do
      it 'タスク一覧画面に遷移し、「ログインしました」というメッセージが表示される' do
        expect(page).to have_content 'タスク一覧'
      end
      it '自分の詳細画面にアクセスできる' do
        visit user_path(first_user.id)
        expect(page).to have_content 'タスク一覧'
      end
      it '他人の詳細画面にアクセスすると、タスク一覧画面に遷移する' do
        visit user_path(second_user.id)
        expect(page).to have_content 'タスク一覧'
      end
      it 'ログアウトするとログイン画面に遷移し、「ログアウトしました」というメッセージが表示される' do
        click_on 'Logout'
        expect(page).to have_content 'ログアウト'
      end
    end
  end      

  describe '管理者機能' do
    let!(:second_user){FactoryBot.create(:second_user)}
    let!(:third_user){FactoryBot.create(:third_user)}
    before do
      visit new_session_path
      fill_in 'session_email', with: 'user3@gmail.com'
      fill_in 'session_password', with: '3333333'
      click_button 'ログイン'
    end

    context '管理者がログインした場合' do
      it '管理ユーザは管理画面にアクセスできること' do
        visit admin_users_path
        expect(page).to have_content 'ユーザ'
      end
      it '管理ユーザはユーザ新規登録ができること' do
        visit new_admin_user_path
        fill_in 'user_name', with: 'user1'
        fill_in 'Email', with: 'user1@gmail.com'
        fill_in 'Password', with: '1111111'
        fill_in 'Password confirmation', with:'1111111'
        check 'user_admin'
        click_on 'Create my account'
      end
      it '管理ユーザはユーザ詳細画面にアクセスできること' do
        visit admin_user_path(third_user.id)
        expect(page).to have_content 'タスク'
      end
      it '管理ユーザはユーザ編集画面からユーザを編集できる' do
        visit edit_admin_user_path(second_user.id)
        fill_in 'user_name', with: 'user2'
        fill_in 'Email', with: 'user2@gmail.com'
        fill_in 'Password', with: '2222222'
        fill_in 'Password confirmation', with:'2222222'
        check 'user_admin'
        click_on 'Edit my account'
      end
      it '管理ユーザはユーザを削除できる' do
        visit admin_users_path(third_user.id)
        click_on'削除', match: :first
        expect(page).to have_content '削除しました'
      end
    end

    context '一般ユーザがユーザ一覧画面にアクセスした場合' do
      let!(:first_user) { FactoryBot.create(:first_user) }
      before do
        visit new_session_path
        fill_in 'session_email', with: 'user1@gmail.com'
        fill_in 'session_password', with: '1111111'
        click_button 'ログイン'
      end
      it 'タスク一覧画面に遷移し、「管理者以外アクセスできません」というエラーメッセージが表示される' do
        visit admin_users_path(second_user.id)
        expect(page).to have_content '管理者'
      end
    end
  end
end