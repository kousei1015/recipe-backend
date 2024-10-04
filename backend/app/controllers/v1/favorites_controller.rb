class V1::FavoritesController < ApplicationController
    def index
        @favorites = current_v1_user.favorites.includes(recipe: { image_attachment: :blob})
    end

    def create
      @favorite = current_v1_user.favorites.new(favorite_params)
        if @favorite.save
          render json: @favorite, status: :created
        else
          render json: @favorite.errors, status: :unprocessable_entity
        end
    end

    def destroy
      @favorite = Favorite.find_by(id: params[:id])
      if @favorite
        @favorite.destroy
        head :no_content
      else
        render json: { error: "Favorite not found." }, status: :not_found
      end
    end

    def favorite_params
     params.permit(:recipe_id)
    end
end
