class V1::RelationshipsController < ApplicationController
    
    def create
        @follow = current_v1_user.relationships.build(followed_id: params[:user_id])

        if @follow.save
            render json: @follow, status: :created
        else
            render json: @follow.errors, status: :unprocessable_entity
        end
    end

    def destroy
        # リクエストのidパラメータを使ってフォロー関係を検索
        @follow = current_v1_user.relationships.find_by(followed_id: params[:id])
        
        if @follow
          @follow.destroy
          head :no_content  # 成功時に204 No Contentを返す
        else
          render json: { error: 'フォロー関係が見つかりません' }, status: :not_found
        end
      end
      

end
