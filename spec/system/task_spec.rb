require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  # let!(:task){ FactoryBot.create(:task, title: 'task')}
  # describe '一覧表示機能' do
  before do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
  end

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'task[title]', with: 'テストタイトル'
        fill_in 'task[content]', with: 'テスト本文'
        click_on '登録する'
        expect(page).to have_content 'test_title'
        expect(page).to have_content 'test_content'
      end
    end
  end

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task, title: 'task')
        visit tasks_path
        expect(page).to have_content 'task'
      end
    end
  end

  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
        task = FactoryBot.create(:task, title: '成功', content: '成功')
        visit task_path(task.id)
        expect(page).to have_content '成功'
       end
     end
  end

  context 'タスクが作成日時の降順に並んでる場合' do
    it '新しいタスクが一番上に表示される' do
      visit tasks_path
      save_and_open_page
      task_list = all('.task_row')
      expect(task_list[0]).to have_content 'test_title2'
      expect(task_list[1]).to have_content 'test_title'
    end
  end
end