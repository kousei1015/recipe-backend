FactoryBot.define do
  factory :instruction do
    association :recipe  # Recipeファクトリとの関連を設定
    description { "MyString" }
  end
end
