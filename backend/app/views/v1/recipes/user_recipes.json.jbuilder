json.data @recipes do |recipe|
  json.id recipe.id
  json.recipe_name recipe.name
  json.cooking_time recipe.cooking_time
  json.image_url recipe.image_url
  json.user_id recipe.user_id
  json.user_name recipe.user.name
end