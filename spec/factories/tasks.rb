FactoryBot.define do
  factory :task do
    title { 'test_title'}
    content { 'test_content'}
    deadline_on { '2022-11-01'}
  end

  factory :second_task, class: Task do
    title { 'test_title2'}
    content { 'test_content2'}
    deadline_on { '2022-11-02'}
  end
end
