User.create!(
  name: "user1",
  email: "user1@example.com", 
  password: "testpassword",
  password_confirmation: "testpassword",
  admin: true )

10.times do |n|
  User.create!(
    name: "テスト太郎#{n + 1}",
    email: "test#{n + 1}@gmail.com",
    password: "1234567",
    password_confirmation: "1234567"
  )
end

10.times do |n|
  Task.create!(
    title: "タスク#{n + 1}",
    content: "content#{n ; 1}",
    deadline_on: DateTime.now,
    status: rand(0..2),
    priority: rand(0..2),
    user_id: User.first.id
  )
  Label.create!(name: "ラベル#{n + 1}")
end