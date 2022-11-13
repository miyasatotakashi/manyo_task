require 'rails_helper'
RSpec.describe 'ラベル管理機能', type: :system do
  let!(:second_user) { FactoryBot.create(:second_user)}
  before do
    # driven_by(selenium_chrome_headless)
    current_user = User.find_by(email: "user2@gmail.com")
    visit new_session_path
    fill_in 'session_email', with: 'user2@gmail.com'
    fill_in 'session_password', with: '2222222'
    click_button 'ログイン'
  end

  describe 'ラベル登録機能' do
    context 'タスク作成時にラベルを選択した場合' do
      it 'タスクにラベルを付けられる' do
        visit new_task_path
        fill_in "task_title", with: "user1"
        fill_in "task_content", with: "user1のやつ"
        fill_in 'task[deadline_on]', with: "2022-11-01"
        select '完了', from: 'task_status'
        select '高', from: 'task_priority'
        check 'ラベル'
        click_button '登録する'
        expect(page).to have_content 'ラベル'
      end
    end
    it 'タスクに複数のラベルを登録できる' do
      visit new_task_path
      fill_in "task_title", with: "user2"
      fill_in "task_content", with: "user2のやつ"
      fill_in 'task[deadline_on]', with: "2022-11-02"
      select '完了', from: 'task_status'
      select '高', from: 'task_priority'
      check 'label1'
      check 'label2'
      click_button '登録する'
      expect(page).to have_content 'ラベル'
      
    end
  end
end