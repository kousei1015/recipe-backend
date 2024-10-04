class V1::RecipesController < ApplicationController
    include Pagination
    def index
      @recipes = Recipe.with_attached_image
    
      if params[:sort_by] == 'cooking_time'
        sort_order = params[:order] || 'asc'
        @recipes = @recipes.order(cooking_time: sort_order, created_at: :desc)
      else
        @recipes = @recipes.order(created_at: :desc)
      end
    
      @recipes = @recipes.page(params[:page]).per(12)
      @pagination = pagination(@recipes)
      @current_user = current_v1_user
      Rails.logger.debug(@pagination.inspect)
    end
    
    def user_recipes
      @user = User.find(params[:user_id])
      @recipes = @user.recipes
      @recipes = @recipes.with_attached_image
      @current_user = current_v1_user
    end

    
    # 下のallメソッドはフロントエンドでレシピ検索するために使います
    def all
      @recipes = Recipe.with_attached_image
      
      if params[:sort_by] == 'cooking_time'
        sort_order = params[:order] || 'asc'
        @recipes = @recipes.order(cooking_time: sort_order)
      else
        @recipes = @recipes.order(created_at: :asc)
      end
      
    end

    def create
      @recipe = current_v1_user.recipes.new(recipe_params)
      
      if @recipe.save
        ingredients = params[:ingredients].values
        
        ingredients.each do |ingredient_data|
          ingredient = Ingredient.find_or_create_by(name: ingredient_data["name"])
          RecipeIngredient.create(recipe: @recipe, ingredient: ingredient, quantity: ingredient_data["quantity"])
        end
    
        # Instructionsの作成
        instructions = params[:instructions].values
        instructions.each do |instruction_data|
          @recipe.instructions.create(description: instruction_data["description"])
        end
        
        render json: @recipe, methods: [:image_url], status: :created
      else
        render json: @recipe.errors, status: :unprocessable_entity
      end
    end    

    def show
      begin
        @recipe = Recipe.includes(recipe_ingredients: :ingredient).find(params[:id])
      rescue ActiveRecord::RecordNotFound => e
        render json: { error: "Recipe not found: #{e.message}" }, status: :not_found
      rescue => e
        render json: { error: "An error occurred: #{e.message}" }, status: :internal_server_error
      end
    end    
    
    def update
      @recipe = Recipe.find(params[:id])
      
      if @recipe.update(recipe_params)
        # 既存の材料を削除
        @recipe.recipe_ingredients.destroy_all
        
        # 新しい材料を追加
        ingredients = params[:ingredients].values
        
        ingredients.each do |ingredient_data|
          ingredient = Ingredient.find_or_create_by(name: ingredient_data["name"])
          RecipeIngredient.create(recipe: @recipe, ingredient: ingredient, quantity: ingredient_data["quantity"])
        end
    
        # Instructionsの更新
        @recipe.instructions.destroy_all  # 既存の指示を削除
        instructions = params[:instructions].values
        
        instructions.each do |instruction_data|
          @recipe.instructions.create(description: instruction_data["description"])
        end
        
        render json: @recipe, status: :ok
      else
        render json: @recipe.errors, status: :unprocessable_entity
      end
    end    
    
    

    def destroy
        @recipe = Recipe.find(params[:id])
      
        if @recipe.user == current_v1_user
          @recipe.destroy
          head :no_content, status: :ok
        else
          render json: @recipe.errors, status: :unprocessable_entity
        end
      end

    private

    def recipe_params
        params.permit(:name, :process, :image, :user_id, :cooking_time)
    end
end
