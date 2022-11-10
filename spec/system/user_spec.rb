require 'rails_helper'

RSpec.describe 'ユーザ管理機能テスト', type: :system do
  describe '登録機能' do
    context 'ユーザの新規登録' do
      it 'タスク一覧画面に遷移する' do
        visit task_path
        fill_in 'name', with: 'user1'
        fill_in 'email', with: 'user1@gmail.com'
        fill_in 'password', with: '1111111'
        fill_in 'password_confirmation', with:'1111111'
        click_on 'Create my account'
        expect(page).to have_content 'タスク一覧画面' 
      end
    end

    context 'ログインせずにタスク一覧画面に飛ぼうとした時' do
      it 'ログイン画面に遷移する' do
        visit tasks_path
        expect(page).to have_content 'ログイン画面'
      end
    end
  end

  describe 'セッション機能テスト' do
    let!(:first_user) { FactoryBot.create(:first_user) }
    let!(:second_user) { FactoryBot.create(:second_user) }
    before do
      visit new_session_path
      fill_in 'session_email', with: 'user1@gmail.com'
      fill_in 'session_password', with: '1111111'
      click_on 'Login'
    end
  
    context '登録済みのユーザでログインした場合' do
      it 'タスク一覧画面に遷移し、「ログインしました」というメッセージが表示される' do
        expect(page).to have_content 'ログインしました'
      end
      it '自分の詳細画面にアクセスできる' do
        visit user_path(first_user.id)
        expect(page).to have_content 'プロフィール詳細ページ'
      end
      it '他人の詳細画面にアクセスすると、タスク一覧画面に遷移する' do
        visit user_path(second_user.id)
        expect(page).to have_content 'タスク一覧ページ'
      end
      it 'ログアウトするとログイン画面に遷移し、「ログアウトしました」というメッセージが表示される' do
        click_on 'Logout'
        expect(page).to have_content 'ログアウトしました'
      end
    end
  end      

  describe '管理者機能' do
    let!(:second_user) { FactoryBot.create(:second_user) }
    let!(:third_user) { FactoryBot.create(:third_user) }
    before do
      visit new_session_path
      fill_in 'session_email', with: 'user3@gmail.com'
      fill_in 'session_password', with: '3333333'
      click_on 'Login'
    end

    context '管理者がログインした場合' do
      it '管理ユーザは管理画面にアクセスできること' 
      visit admin_users_path
      expect(page).to have_content 'ユーザ一覧ページ'
      end
      it '管理ユーザはユーザ新規登録ができること' do
        visit admin_users_path
        click_on '新規ユーザー登録'
        fill_in 'name', with: 'user1'
        fill_in 'email', with: 'user1@gmail.com'
        fill_in 'password', with: '1111111'
        fill_in 'password_confirmation', with:'1111111'
        check 'check_admin'
        click_on 'Create my account'
      end
      it '管理ユーザはユーザ詳細画面にアクセスできること' do
        visit admin_user_path(third_user.id)
        expect(page).to have_content 'ユーザ一覧ページ'
      end
      it '管理ユーザはユーザ編集画面からユーザを編集できる' do
        visit edit_admin_user_path(second_user.id)
        fill_in 'name', with: 'user2'
        fill_in 'email', with: 'user2@gmail.com'
        fill_in 'password', with: '2222222'
        fill_in 'password_confirmation', with:'2222222'
        check 'check_admin'
        click_on 'Edit my account'
      end
      it '管理ユーザはユーザを削除できる' do
        visit admin_users_path(third_user.id)
        click_on'削除', match: :first
        expect(page.accept_confirm).to eq '本当に削除してもよろしいですか？'
        expect(page).to have_content 'ユーザを削除しました'
      end
    end
    context '一般ユーザがユーザ一覧画面にアクセスした場合' do
      let!(:first_user) { FactoryBot.create(:first_user) }
      before do
        click_on 'Logout'
        visit new_session_path
        fill_in 'session_email', with: 'user1@gmail.com'
        fill_in 'session_password', with: '1111111'
        click_button 'Login'
      end
      it 'タスク一覧画面に遷移し、「管理者以外アクセスできません」というエラーメッセージが表示される' do
        visit admin_users_path(second_user.id)
        expect(page).to have_content '管理者以外はアクセスできません'
      end
    end
  end
end