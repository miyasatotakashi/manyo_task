require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  # let!(:task){ FactoryBot.create(:task, title: 'task')}
  # describe '一覧表示機能' do
  before do
    FactoryBot.create(:task, title: "first_title", content: "first_content", status: '完了')
    FactoryBot.create(:second_task, title: "second_title")
  end

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'task[title]', with: 'テストタイトル'
        fill_in 'task[content]', with: 'テスト本文'
        click_on '登録する'
        expect(page).to have_content 'first_title'
        expect(page).to have_content 'first_content'
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
      task_list = all('.task_row')
      expect(task_list[0]).to have_content 'second_title'
      expect(task_list[1]).to have_content 'first_title'
    end
  end

  context '終了期限でソートするをクリックした場合' do
    it 'タスクが終了期限の降順に並んでいる' do
      visit tasks_path
      task_list = all('.date_row')
      expect(task_list[0]).to have_content '2022-11-02'
      expect(task_list[1]).to have_content '2022-11-01'
    end
  end

  context 'タイトルであいまい検索をした場合' do
    it "検索キーワードを含むタスクで絞り込まれる" do
      visit tasks_path
      fill_in 'task_title', with: 'first_title'
      click_on '検索する'
      expect(page).to have_content 'first_title'
    end
  end

  context 'ステータス検索した場合' do
    it "ステータスに完全一致するタスクが絞り込まれる" do
      visit tasks_path
      select '完了', from: 'task_status'
      click_on '検索する'
      expect(page).to have_selector 'td', text: '完了'
    end
  end

  context 'タイトルのあいまい検索とステータス検索をした場合' do
    it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
      visit tasks_path
      fill_in 'task_title', with: 'first_title'
      select '完了', from: 'task_status'
      click_on '検索する'
      expect(page).to have_content 'first_title'
      expect(page).to have_selector 'td', text: '完了'
    end
  end
end