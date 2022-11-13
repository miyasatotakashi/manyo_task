FactoryBot.define do
  factory :label do
    name {"test"}
  end

  FactoryBot.define do
    factory :first_label, class: Label do
      name { "user1" }
      user_id {1}
    end
  end
end
