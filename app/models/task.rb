class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  enum status: { 未着手:0, 着手中:1, 完了:2 }
  enum priority: {高: 0, 中: 1, 低: 2}

  scope :title_search, -> (text_title) {where("title LIKE ?", "%#{text_title}%")}
  scope :status_search, -> (select_status) {where(status: select_status)}
  scope :label_search, -> (select_label) {where(id: TaskLabel.where(label_id: label).select(:task_id))}

  belongs_to :user
  
  has_many :labellings, dependent: :destroy
  has_many :labels, through: :labellings, source: :label
end
