json.data @recipes do |recipe|
  json.id recipe.id
  json.recipe_name recipe.name
  json.cooking_time recipe.cooking_time
  json.image_url recipe.image_url
end

json.pagination @pagination