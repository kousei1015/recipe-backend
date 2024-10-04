json.array! @recipes do |recipe|
  json.id recipe.id
  json.recipe_name recipe.name
  json.image_url recipe.image_url
end
