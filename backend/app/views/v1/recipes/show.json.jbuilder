json.id @recipe.id
json.recipe_name @recipe.name

json.image_url @recipe.image_url
json.user_id @recipe.user_id
json.user_name @recipe.user.name
json.avatar_url @recipe.user.avatar_url
json.cooking_time @recipe.cooking_time
json.instructions @recipe.instructions do |instruction|
  json.description instruction.description
end
json.ingredients @recipe.recipe_ingredients do |recipe_ingredient|
  json.name recipe_ingredient.ingredient.name
  json.quantity recipe_ingredient.quantity
end
if current_v1_user
  favorite = @recipe.favorites.find { |fav| fav.user_id == current_v1_user.id }
  json.favorite_id favorite.id if favorite
  follow = current_v1_user.relationships.find { |rel| rel.followed_id == @recipe.user.id }
  json.follow_id follow.id if follow
end