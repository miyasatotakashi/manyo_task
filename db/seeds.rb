User.create!(name: "user1", email: "user0@example.com", password: "testpassword", password_confirmation:"testpassword" )
Task.create!(title: "初めて", content:"ファーストユーザ",user_id: 1)