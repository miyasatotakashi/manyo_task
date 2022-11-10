FactoryBot.define do
  factory :first_user, class: User do
    name { "user1" }
    email { "user1@gmail.com" }
    password_digest { "1111111" }
    admin { false }
  end
  
  factory :second_user, class: User do
    name { "user2" }
    email { "user2@gmail.com" }
    password_digest { "2222222" }
    admin { false }
  end

  factory :third_user, class: User do
    name { "user3" }
    email { "user3@gmail.com" }
    password_digest { "3333333" }
    admin { true }
  end
end
