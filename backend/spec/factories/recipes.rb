FactoryBot.define do
  factory :recipe do
    name { Faker::Food.dish }
    association :user # Userファクトリとの関連を設定してます

    after(:create) do |recipe|
      create_list(:ingredient, 3).each do |ingredient|
        recipe.ingredients << ingredient
        
        # 中間テーブルのquantityを設定する場合
        recipe.ingredients_relation.find_by(ingredient: ingredient).update(quantity: Faker::Number.between(from: 1, to: 10))
      end
    end
  end
end
