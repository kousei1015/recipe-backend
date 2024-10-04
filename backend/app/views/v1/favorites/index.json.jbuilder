json.array! @favorites do |favorite|
    json.id favorite.recipe.id
    json.recipe_name favorite.recipe.name
    json.cooking_time favorite.recipe.cooking_time
    json.image_url favorite.recipe.image_url
end