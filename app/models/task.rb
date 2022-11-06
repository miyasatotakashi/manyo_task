class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  enum status: { 未着手:0, 着手中:1, 完了:2 }

  scope :status_search, -> (select_status) {where(status: select_status)}
  scope :title_search, -> (text_title) {where("title LIKE ?", "%#{text_title}%")}
end
