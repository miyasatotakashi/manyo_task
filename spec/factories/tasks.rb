FactoryBot.define do
  factory :task do
    title { 'first_title'}
    content { 'first_content'}
    deadline_on { '2022-11-02'}
  end

  factory :second_task, class: Task do
    title { 'second_title'}
    content { 'second_content'}
    deadline_on { '2022-11-01'}
  end
end
