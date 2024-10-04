class V1::UsersController < ApplicationController
  # before_action :authenticate_v1_user!, only: [:index]

  def show
    @user = User.find(params[:id])
    @followings_count = @user.followings.count
    @followers_count = @user.followers.count
  end

  def followings
    @relationships = Relationship.where(follower_id: params[:id])
  end
    
  def followers
    @relationships = Relationship.where(followed_id: params[:id])
  end

  def myfollowings
    @relationships = Relationship.where(follower_id: current_v1_user).includes(followed: { avatar_attachment: :blob })
  end

  def myfollowers
    @relationships = Relationship.where(followed_id: current_v1_user).includes(follower: { avatar_attachment: :blob })
  end

  def current_user_info

  end
end
